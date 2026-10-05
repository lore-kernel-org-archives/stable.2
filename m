Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31854C226D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213059; cv=none; b=NMnMcGblh1gRZAGzBWql9r0WMdyIEG7rGWyYBuT9WpvNabjQUOAPk+m0ol8GHG4EfMRo55oK12rHRPXanf/pTFoQVUB+hsaOoz6qp9WaLL33SPdkz8lEh3Rru9sKSAbmRojPEYzi1yXUpyiiPvjSsxX4vZlWDKZciPPkFAu09Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213059; c=relaxed/simple;
	bh=6B9T2UlZ5jQCOpAZFU4QzYs4yLoZF+6jMnenlHdnT1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgksJYWK3NlaLQZhIC4pLHROuHZpmMFEK7txOUhO3UeYULlq/S8Qnw+Zl6/Jlv6M4eAFGk0mh4zN4xr3U+EWTE6/T+Rsp5mbyh4COdlTalj9ojQOScQ9YPypbG01+1Vsc7Js2TpOK8mSpNW6fSG2YucAZEpcuRa+RXr9tQX8B1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMjTmJFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMjTmJFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20F51F000FF;
	Mon,  5 Oct 2026 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213057;
	bh=taG/s0itAquUrhbAF+8Pa3a1olERdcisbZVMl3iyZYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMjTmJFbDv4E8t2ptcZD1myJ+2EBJNfFRBPyKoE3UcsuxMoSpSssQlwVzcad3vlS+
	 JwC6frplwldMj1dggztJUY2RPvQQdWk+9VXFw7dgiIzIHu+cGBtCkoriuPVfToQMda
	 dj8NjE7B2YLgIpCGsYO5OtjNsX3YukfmgLi0eIaFQgcbkF9OcSSY/P40D/ATLPF/Ci
	 figHmoleW4OdO2ZASVIZ88drSCSKyZf2OPGnbLf/NQVQBDSm3aWtJYIhksqCgBdbI8
	 ld7s0uQLEZdESDo7BiuIwdVi1tTnmUxKm8RU8MnPoVPIV7ARpvnzexF1GMKzOZ+cqX
	 PhlibZTJOfjKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] usb: ohci-spear: disable controller wakeup on removal
Date: Mon,  5 Oct 2026 11:10:52 -0400
Message-ID: <20261005151017.3044548-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005151017.3044548-1-sashal@kernel.org>
References: <2026100502-nanometer-helpless-c302@gregkh>
 <20261005151017.3044548-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb ]

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260915012011.61874-4-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 986406f7aeb15..7d798b3e75171 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -105,6 +105,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
-- 
2.53.0

