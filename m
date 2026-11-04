Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805360;
	b=sVklJOFl0xHtYLFR8oH975vwCRoZftaF5gEGlv0PCbol09tJeL2h2pwwNBgz9/yYzk+c
	 9WtNiiKbDP41wJeUQgSPRp81vDW1S2iZ9+vGVDjDvNLWs1BoAOo4kp0Sh+YvmvMAjfv3m
	 awYetG2I6JNejUXX4SOk33Tabwvhu/Eq98h+cLSvP1oGEcWOsAuzSOcK4ZnG0/BY7rj6M
	 y/nxIBJvQyJc2p+woRuLsoY+4oVKtJlQH0iumzSxtXYtPoiH2a27859QG64WgBLboGj2M
	 m2G4YOPRzJdDqE/Buam/LXIh9pREoJ/tpgyhl7u6H9L4XBccY7xB8X98eKTRjORUyTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805360;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ljsjPYwaUQfrGLBIfF8l1JYTpP0ds7LDpqQWZ8STY7E=;
	b=su7h8n5CXPjFkHJZRzJnSUO3oZQSS+Z60C6FfDnLebRHiib/qOBTl4UUrEb7ZfMc4eKs
	 yOOguoggOK3zieUe589SOVHyUn5PIRbVORY+eySFeZEJc5GtJTyFeKYqszUjO3Uh6ujUl
	 CsXti+pQUBDVHsVPy6SOb5z7gQOsJy0Aa+JC/uFwFw+F0jsSnPOngeJyFhyc90uiv3nKg
	 pOlD1KdHP/Q75bJDLXOAeIzTqPwLyRe45xuKielHI5wMUO9oxa+MTODJiUb4HkDGUMvLn
	 8IxFTpexLvvJFYsvlY2290SnR0x0BWwhuaWhO4VNjxtlPP+kxtDTeczHNOyetCE4Q4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E96606A338;
	Wed,  4 Nov 2026 15:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58E96606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ljsjPYwaUQfrGLBIfF8l1JYTpP0ds7LDpq
	QWZ8STY7E=; b=YrVml1CgC8ptwnvyJldjTuCMEM9Rf5FV6otzo4pXYH9K/Hbt4i
	gVxVPoVOTFyfPwZz6cJ96mCGdrTH1Fcvbpv/n8ANAJapltzTxdh8Bs//A/nVL2Te
	YQwMHWwIdgYblGvmDQUIqyfUs7H6d3zv7kfE96ZOpjCsCv1AA5xdWpVwY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.59])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCWm_4gTOtqMzskAQ--.48211S2;
	Wed, 04 Nov 2026 23:15:45 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH v5] usb: xhci: Fix use-after-free race in xhci_stop_device()
Date: Wed,  4 Nov 2026 23:15:44 +0800
Message-Id: <20261104151544.26672-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
References: <20261104000031.679944e7.michal.pecio@gmail.com> <20261104035637.3325-1-25031212351@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCWm_4gTOtqMzskAQ--.48211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kZr18Zr1rWw1rZryDtrb_yoW8Gw4rpF
	W3XFW5GFykGw43Wwn7Zw1UJa4rJw4fZF93uwn7Z3yUA398GryFyr10kFWYv3W3Crs7Xa4j
	yF9Yq3s7Was8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jzHqcUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUHD2rp+NX6FAABsN

Alan,

Thanks - that is a fair point, and I agree that the generic exposure is in
the core: usbfs can drive port state on a hub whose driver is being
unbound, and usb core does not serialize the two.

The awkward part is where the lock would go.  do_proc_control() releases
usb_lock_device() around usbfs_start_wait_urb(), so the control request to
the hub runs without the device lock, while usb_unbind_interface() ->
hub_disconnect() holds it.  Making those two exclude each other on that
mutex would mean holding it across a synchronous URB, which I do not think
is acceptable.

Two shapes I can see on the core side:

 - refuse or queue hub class requests to a hub while its driver is being
   unbound, or
 - make usb_disconnect() of that hub's children wait for in-flight
   port-state requests on that hub first.

I am happy to prototype either one; tell me which you would prefer.

What is xhci-specific is that xhci_hub_control() is the only one of these
paths that walks per-device state: xhci_stop_device() looks up
xhci->devs[slot_id] and drops xhci->lock while sending the stop endpoint
commands.  ehci/ohci/uhci only write port registers there, so the same
interleaving does not give them a use-after-free.

So I would like to keep the xhci hunk as well, as memory-safety hardening
for the case where the core does not catch it.  If you would rather see
the core change first, I can send that separately and rebase this on top
of it.

YuanZhe

