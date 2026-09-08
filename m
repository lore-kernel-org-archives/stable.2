Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D852ED4A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870646; cv=none; b=fZ4b167pz4/pbN2tcGp09Z70GGi/meoWc+IyT9oW5MC7zRPUv9WliN6PR3c/Dh53TDU+CHvSQPXQdZuRsxwwdxWBRYxUMuMDnivZmbCPhl97Cj5REElGB09lCiaEUsmBlFVtqFPLWh0prtImk74UXqRqclVMSKNciqz1llE7X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870646; c=relaxed/simple;
	bh=IMqDmomMqXgvmxVtg/ZkiWKcJ22L56UN/7oiKdbJYP8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MlBijxGBNy2uwycCT32hykMcYxLbMiz6AWcHE1JqCZizK+h2/lE+SFN7a1HerOkXYlwbhtjam0tstzl1iO+FN6GQsvpu0nfHfn1ScS7TVD7Aqm+mzzLryH1NaR9tFfd7kj2hLIqjOnF0g9er8a+CGDMqieqQhmrn+/5TPvXdkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCckUrKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCckUrKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4181F00A3A;
	Tue,  8 Sep 2026 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870644;
	bh=tokfPpCGeUGACr96dRs5yUeH4Hf567qo7802IVeBNHU=;
	h=Subject:To:Cc:From:Date;
	b=pCckUrKZUGkn8etYOVUA5+wrgyO4Pyr7KcNTtC1dcP58xj6HLg1f3zmDflPX5pjaC
	 dgC5XxPEXIKGrthD3VXF4eHpSzm72yAJUgmmjNqYRV7VYk6DWNARczIOuaYnTONFdW
	 7lY+iMUO8zXGO3FbCLX0h34N7EdKhRkf6okhul5Q=
Subject: FAILED: patch "[PATCH] usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,bryan.odonoghue@linaro.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:30:36 +0200
Message-ID: <2026090836-sublet-submersed-cfc4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c9273c83885835dbd1e8835d5665dfb8503d65e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090836-sublet-submersed-cfc4@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9273c83885835dbd1e8835d5665dfb8503d65e0 Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 20 Aug 2026 13:53:07 +0000
Subject: [PATCH] usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if
 port_start() fails

cc_debounce_dwork can be queued before port_start() fails:
tcpm_register_port() runs first, and its state machine may invoke
set_cc() or start_toggling() from the TCPM worker.  The error path then
calls tcpm_unregister_port(), whose worker flush may queue the delayed
work before devres frees pmic_typec_port.

Disable and drain the delayed work directly at port_start()'s error
exit.  Do not use port_stop() for this path: its IRQs use IRQF_NO_AUTOEN
and are enabled only after a successful port_start().

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable <stable@kernel.org>  # v6.10+
Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260820135307.153773-3-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index d43799f43184..d3523435f3e0 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -683,6 +683,9 @@ static int qcom_pmic_typec_port_start(struct pmic_typec *tcpm,
 		enable_irq(pmic_typec_port->irq_data[i].irq);
 
 done:
+	if (ret)
+		disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
+
 	return ret;
 }
 

