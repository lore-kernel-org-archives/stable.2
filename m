Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2953A891
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870616; cv=none; b=AVE7iAyJRkYbtclJ/W1KUXKhMrI0ySfcyIhZ23GyQeV0qH56ETm02ojUxdO/1OBhpmSidPtxPBj36o02L/zDAXHDgdKW9UHoiyn+PqDq2oyIW0rFv7OjJ6Ym0TIRLqAFMKqYKnt/xrniNIRym6P+tYG6R5sWZqPb/neEARfoY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870616; c=relaxed/simple;
	bh=Q7P/KEuW+23nOKVVaSqkRp1aAu/a0Slkb0HROAn9MR4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EPDliBRHVq+FHxEnKM1CokUglwaukWqHDh+qURJeoWPJAmz8ZsqHR9IVKuCje1Ro9pNv7UY4tL8T2g/YJuCvw1zWwkfwZLQ6R7LAanajwpUuvpdtFfLLr8gJS0jmm1/tgQgeqew07fjaKPgPvle50uMTarA1k3UTHpoutSBimqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kr+eLLIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kr+eLLIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0304A1F00A3A;
	Tue,  8 Sep 2026 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788870614;
	bh=kUcP+PTdvHKBJ50xXRUsozs7LvlUnY4xwPh94mrNpps=;
	h=Subject:To:Cc:From:Date;
	b=kr+eLLIuEeTj8Fcx7PxmSri8MHc6xN6pc8e0zkw7xhaQ50utRiHDACezlevW03Ulw
	 K5ApIEcarYVCmvGIxuX9xmQTfBd5qLfjFyiTOD+KoiAOE69z30DBf1PIuDx/g820Zi
	 wbMGD1jBWheH8p/Dr/EGittqDm5w+Xx59ZgOyJkk=
Subject: FAILED: patch "[PATCH] usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on" failed to apply to 6.6-stable tree
To: fanwu01@zju.edu.cn,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:30:07 +0200
Message-ID: <2026090807-unbalance-starlet-1c55@gregkh>
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
git cherry-pick -x 263f7d61a4201cde16849b2d016251806e7418be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090807-unbalance-starlet-1c55@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 263f7d61a4201cde16849b2d016251806e7418be Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 20 Aug 2026 13:53:06 +0000
Subject: [PATCH] usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on
 stop

cc_debounce_dwork is queued from the set_cc() and start_toggling()
callbacks, which run from TCPM's kthread worker.  port_stop() returns
before tcpm_unregister_port() destroys that worker.  Flushing the worker
during unregister may therefore run a callback which queues the delayed
work after port_stop() has returned.

The delayed work can then run after devres has freed pmic_typec_port.

Use disable_delayed_work_sync() in port_stop() to cancel a pending
instance and prevent the TCPM callbacks from queueing another one.

This issue was found by an in-house static analysis tool.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable <stable@kernel.org>  # v6.10+
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260820135307.153773-2-fanwu01@zju.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index bf985efe1cd6..d43799f43184 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -693,6 +693,8 @@ static void qcom_pmic_typec_port_stop(struct pmic_typec *tcpm)
 
 	for (i = 0; i < pmic_typec_port->nr_irqs; i++)
 		disable_irq(pmic_typec_port->irq_data[i].irq);
+
+	disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
 }
 
 int qcom_pmic_typec_port_probe(struct platform_device *pdev,

