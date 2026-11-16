Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826404;
	b=ek/1Pg80kRoWNq3Px3TEgD2FqTjJiEhr8D4+1+qe12F1RTKKiXs122KdZw8CD9fnl26J
	 6mt4neLlaQ/NN3Mbb09gAr7qfybfR6yWo6V5dOAgRxhq/cndIh1U7APBp64wyj8KWKxu2
	 wC32zN8fQrr/ytROSrPknMDvRTq+Wy92T2eU7q/rcIUusYYT8UOxaA4PeOe/Gv7b1DSlS
	 38MgPBhlb2E6v1Z7NIHtpnSkoZVC6IOSAq/LHbwM+az39J0PctPsmJpnlrxZn3JaaTLks
	 I+MJso4kxUYhkBgqZABKf/pC8wdelQ2I/gYDipfmije7VjH+rt17Y/DRoBQV/2WRv5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=C9XkwvpUokenqd29JuI3QrAxLajRAdLPVH8Z6H0RKZE=;
	b=JxlCgsigRExZpr3cbhmCLS6k5Ua2TE7axGwuKmIdg7ZcFjiakvYu0wyHXjH8SkJFb40z
	 PWxgHBx599sVBfHGkAPBy6HDz/ILvPidWz+zNOpqscY9MK/40nD09krmq0u2+SDnou/BX
	 T9c5xFArnRg0hxddZ64duZz2GjBUQV4IetuSFGEIRsF4Gds97VDtpwjrwaTtr3C8WLT+B
	 9G6FEkKDixWEneyuyqvEeKd/hyJv7Rgki9z79HHzQtXhGyt+3uyNtKk1GsDvttH/+2NnS
	 QVLKMiabFpMsZFY+eCg/rfnZ0VfnfG9O7wlGqVbLJeJLMXAQJYqFMXL7VpCZ/JcmDVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLuQW7u6;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9D606A8B9
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD9D606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLuQW7u6
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c10dc41270so3428596e87.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826402; x=1795431202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9XkwvpUokenqd29JuI3QrAxLajRAdLPVH8Z6H0RKZE=;
        b=lLuQW7u6Q4kNTLsC5pVKBRxBayX4JLg406lxIRCZFZ1bJsl2ZonFKAGhFUcKIUbxir
         6SRCnCrcGHktrMrZJbi5RBAEiU1H+qGGu7ehhIEFTNQ3slkKYdr2jASll5CPlhj8Q/wN
         9DYGY8N/GFolGvAOj1TJnTYI+3qM6hnwO5IJlwZjOb7NzZNIXdfjNf+3rZ9PCYk/xNk9
         MEfisYR8O7amsgMOS99rxPjT68zy2QaFbPL3eCGhh387KoJREMMqhoPGPrUcVJ01oWNG
         s31Uqe6ppoP2dv0Q1gnaCg6OrfWFKLNdc24I2gw7eq+BvW2oXisZNC+ybQ7wQrbdiokb
         +HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826402; x=1795431202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9XkwvpUokenqd29JuI3QrAxLajRAdLPVH8Z6H0RKZE=;
        b=OXRiON8aZ/ns8VpLOPjj296ktJYNA9lPDsWsqMxj9rjuxRULtgre9WNNiZVzejF4t8
         wGUmWFa/EKysUVVMf4dYDoOuWPOwB5US0hMyURWWNfrFfXvrHI5BtdzUWl/LRS16yhoD
         TPCRVRi89C6esxrCS/Kqdy9gq2ey91ny9Blgb62OACwEVAU3HFeUApLo8wdmBPAYjJOg
         IqoCn4B8Hp5SjurLWYMgr0t6Ea05fxWx9I07D5/PHvhf7mCIiyMP9h1dXjf6mFF/REMJ
         74WfTVPm6Nlo/ax3YVVcUaSR9zq5mGYVAXCn0yMHQVQxZUljC91uhhhu92A/M/AGUNnh
         x39Q==
X-Gm-Message-State: APuU4Z8B6DC/uvjAIZ9wonH2QSpypXdFX8CXdZFB9R1bYc2bieSRakj4
	yBXWWk3+SVheTDQ3MoC9IFUvXWx46OnRgUeh2ZnkJj5ne9qN7laBnVz5XRUsYvPu
X-Gm-Gg: AYBFou0OFwism1I2GYIqgh0Py1dajdlnz0Af23bUdkTbt1lahnQTrDzeeNvaza6Oxs9
	RHmDPVligN8OFPHe8BU/T2FhTfPqAp8/iL4G1545qZlT1n5SUbfm/8OE6eIyF/olXG9fVG0THtO
	lLXFSBXG7edZ2YNyMah2ZEWKfdySzYOcW+h2Vy9g0dqyWqtm4/2/d61nQkqY14ENTpc3+h4ZS56
	iFT4huLRhI5PBnC3Rohx7FZeJH/UPPXyQbCVc9Jpii/5o8t+AOSPCOBNKrKVl5LhEqRTBJZA413
	1/W6IofHsn0PwME8pfAcOBvv8pgyt9Q0cUR6+RkISa94RQmtJPymP4DefXSpGSoydEFK03H7eAt
	kswNij3lAnalTLzuJyB9XWw8X84puuZi16u3ZpNN0vF7nL7qeMZwzI2rQXdvh7+HGwgqEJXvdj9
	Kr8waivzE5ob24SKm188IZ5pKsOJKzY2dgfCaJGdqmxFZmTbaAc99redk3RQ27B/7z99SsGA6of
	+JNg9M9ORhYwXA2HMfcgDv8pMEI/4uEBeib22wrWqZMW4ddCkmsYYs7J1VkE8SIPakrw7A00Wq9
	Pd7MwGDJ0g3a0rwHJviHqA==
X-Received: by 2002:a05:6512:3345:b0:5bf:b603:365d with SMTP id 2adb3069b0e04-5c1709d6b21mr3686877e87.10.1794826401844;
        Mon, 16 Nov 2026 02:53:21 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7ae909sm31601781fa.25.2026.11.16.02.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:20 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Kanner <andrew.kanner@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 17:53:06 +0700
Message-ID: <20261116105307.89727-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

commit 1df83cbf23a27174aee6ea5e52462f03f7e48a10 upstream.

KMSAN reports the following issue:
[   81.822503] =====================================================
[   81.823222] BUG: KMSAN: uninit-value in selinux_inet_conn_request+0x2c8/0x4b0
[   81.823891]  selinux_inet_conn_request+0x2c8/0x4b0
[   81.824385]  security_inet_conn_request+0xc0/0x160
[   81.824886]  tcp_v4_route_req+0x30e/0x490
[   81.825343]  tcp_conn_request+0xdc8/0x3400
[   81.825813]  tcp_v4_conn_request+0x134/0x190
[   81.826292]  tcp_rcv_state_process+0x1f4/0x3b40
[   81.826797]  tcp_v4_do_rcv+0x9ca/0xc30
[   81.827236]  tcp_v4_rcv+0x3bf5/0x4180
[   81.827670]  ip_protocol_deliver_rcu+0x822/0x1230
[   81.828174]  ip_local_deliver_finish+0x259/0x370
[   81.828667]  ip_local_deliver+0x1c0/0x450
[   81.829105]  ip_sublist_rcv+0xdc1/0xf50
[   81.829534]  ip_list_rcv+0x72e/0x790
[   81.829941]  __netif_receive_skb_list_core+0x10d5/0x1180
[   81.830499]  netif_receive_skb_list_internal+0xc41/0x1190
[   81.831064]  napi_complete_done+0x2c4/0x8b0
[   81.831532]  e1000_clean+0x12bf/0x4d90
[   81.831983]  __napi_poll+0xa6/0x760
[   81.832391]  net_rx_action+0x84c/0x1550
[   81.832831]  __do_softirq+0x272/0xa6c
[   81.833239]  __irq_exit_rcu+0xb7/0x1a0
[   81.833654]  irq_exit_rcu+0x17/0x40
[   81.834044]  common_interrupt+0x8d/0xa0
[   81.834494]  asm_common_interrupt+0x2b/0x40
[   81.834949]  default_idle+0x17/0x20
[   81.835356]  arch_cpu_idle+0xd/0x20
[   81.835766]  default_idle_call+0x43/0x70
[   81.836210]  do_idle+0x258/0x800
[   81.836581]  cpu_startup_entry+0x26/0x30
[   81.837002]  __pfx_ap_starting+0x0/0x10
[   81.837444]  secondary_startup_64_no_verify+0x17a/0x17b
[   81.837979]
[   81.838166] Local variable nlbl_type.i created at:
[   81.838596]  selinux_inet_conn_request+0xe3/0x4b0
[   81.839078]  security_inet_conn_request+0xc0/0x160

KMSAN warning is reproducible with:
* netlabel_mgmt_protocount is 0 (e.g. netlbl_enabled() returns 0)
* CONFIG_SECURITY_NETWORK_XFRM may be set or not
* CONFIG_KMSAN=y
* `ssh USER@HOSTNAME /bin/date`

selinux_skb_peerlbl_sid() will call selinux_xfrm_skb_sid(), then fall
to selinux_netlbl_skbuff_getsid() which will not initialize nlbl_type,
but it will be passed to:

    err = security_net_peersid_resolve(nlbl_sid,
                                       nlbl_type, xfrm_sid, sid);

and checked by KMSAN, although it will not be used inside
security_net_peersid_resolve() (at least now), since this function
will check either (xfrm_sid == SECSID_NULL) or (nlbl_sid ==
SECSID_NULL) first and return before using uninitialized nlbl_type.

Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
[PM: subject line tweak, removed 'fixes' tag as code is not broken]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 security/selinux/netlabel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 800ab4b4239e..1c316af68bf3 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -196,6 +196,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	struct netlbl_lsm_secattr secattr;
 
 	if (!netlbl_enabled()) {
+		*type = NETLBL_NLTYPE_NONE;
 		*sid = SECSID_NULL;
 		return 0;
 	}
-- 
2.55.0
