Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826450;
	b=H5oh6E8NyE6rF4OuweZDOs9ksie4I+AtDO04U/cWJ2HYiupB2SdHYtqiqhB2RbSN4xra
	 Abw0882KtFtz8S5yU4yjPvaK2/fIU2vAynD1T1MgSLIVpoSWNL4zzBOg5ykpcBhz73BFT
	 I+a9Q9B5YZk7tSbROZTZTHXLMrNjTY2TC/PyB6EJaU+fyCjGzi3GT0qIDjltdxiXLIJgm
	 Q4LTRQnkbscsgi/pYQ5U4tH3GJs5CYigauOhk1WXBYdebIgqaOEqJuJ3Zoju3e/hj23fU
	 CHURLG/Q5j/bnwlI9NkSeki0UgETGz2bTvxsmB53wGsbQhsSfgs3/bRtOev0Gg2zu+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
	b=jcyr5dCZeZcVg80e5//NNeqXuOmBlLuw86vmI2Y6nxJFHbTDw/EPexpwffdHHHEFy45e
	 3/M+jTBoVQ5MC3wf+onYF6TqiukLx3Z/8OBTEaqsVLebPyn/Og/ADH6CDK/fV5xJ2Gyvj
	 1rieFwDveNt9DZmEiTKuMrvrybQCZcaNdOicxP0mS/BvnEOJNf2L63fVk7fQxaCp+l669
	 WYZ30N/KLl+Y6Gmq2/4MT+FQaG7weULFpyjz3yfsUEFBSR2rXNI0TStsJT+OUH3nKLjjC
	 vP5EiiNwyeip2JPHSZcXqzUF1oYJqvzQgeH4BelIK7TJzW+ZbT3n5KM+uAV84HT9ghA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6uqr42W;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927E606A333
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B927E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6uqr42W
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so4034413e87.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826447; x=1795431247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
        b=V6uqr42Wj5tCt2pj4NsxEWUA9ZPV2hJ8vbtfEJHqEWup61LERHaYBhxJtqUNRTqLwu
         xjS8Wcw1MkaEVKEW2FlvbzSlniIrC4yQncyGGWN7oyxOkcmIllBELJ3GHhZ1eM1mV5lk
         DtJy3osQM+taLpTs1LMUb0MlchzFAVsx54QVwlRbrGzDEGJzBoizYdOJWp0TP5ytlmXb
         ZS+NlW9pzXwzAy0GCVNgPoQfZt58VL4fpFeqUBnlW1PkKFGWF5lBPZcB22zzj37sQbBC
         aEV9U5r/FbgH2GaZXhpQgTBC8htE5gWHKQOlkUFAZMtEI5pCvGVxE1kfJ8ruW8PzjV1m
         EE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826447; x=1795431247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdKuq3/Fu2jW7L/YxaeYVgsN39DZtPGFu/e9jRJDqRI=;
        b=ijsr/gtEWXfCpVAniLt3exRMbUPRUi2InzUw1iig9zOZi+Mvg3H7g0RiD5NcM+w+4d
         pWSr8/a1gtRVFNnUUzy+YtPwm09Esd3oYES0b3cQX+mNWhTIIobQcZJdMVU/bHbsYEeK
         8WVhSZqjnFsLDXnBUC1vlQcg/1PTEE7xUb6c8O0dkM1lO5kQXh9ShJlFZNX+396V9h6M
         ckcQZ6zVway1ZtAF+L55NahA4b1ZbGO7XkFmJNLQyIl8DUIiyTNjoWv2T3fSoSre+PuJ
         5r448q/gI9VfED70IvUi9q6wTVqwR8z2GF1cI6A02usgn2pF4IqXLackeYchyMHhPdVs
         fJzQ==
X-Gm-Message-State: APuU4Z+mQWkzpdPR2ZswVM8yRGnQA854SXafAYmlKJn4wKyXwi5HgTeW
	pee/uodNYMGjK5J85uS5lGfAOB4V+nkkdXc35NkhlclY8YJMbke17i+dLMxRuBj2
X-Gm-Gg: AYBFou2xGsGc2pXd6arPgYnbLqA1b2SdpDm3QOq2NZAdPFVfiaEcAKaUlBXgED/rSIV
	HD/eEm30pr74yB3YPNMtZ3K0tNGg15NMXjCcCSeBdzlu6aVrCqdIXBbLCGuXSqV+odGjUggL+mm
	+g9XCi5hPkRX/o6x2LMusQ6tOXuJxm1iTDknSlkuBFcEOGmoTkeTFqlqqZqQ3ZY/o615y9kvkqF
	sOCGdj/dBkKm5Ed8oG05TZvlf7G9P0nvWkE3Xd5PZfnj1MVg122pZtwalRfp326PPwxxzlW+fne
	ZO5HcaqtbUEWnjba8UM9Pxr/EruW+96Nwk0aeOV0k55Xmvd57nnOc5mMDh6FliJt5dcsV3z8NdA
	yNlBXOM/UjZsjkMuOX5sy9c3t+ot/3LAqQC6Uc/FpB52EB2x1Gwzdr+ARpuihloZwQZ++L5F5LC
	ka/JxGOvt/t36nKhwn6H/uxdxcZg/xjnPbnVU0fxuELVbarz943xNECqLPkoDR2//ho0i4zLomH
	8chBacnXwbObuOOUscMSDpDiWBeTS8rJFob0/S4DSUz7514X7ccOXXj/TDZq2CnybeJE85sFmTj
	036EPPzd08TKcF0w0cOj
X-Received: by 2002:a05:6512:1322:b0:5c1:5b06:27c0 with SMTP id 2adb3069b0e04-5c170731f7dmr3105250e87.3.1794826447410;
        Mon, 16 Nov 2026 02:54:07 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133c663sm3069194e87.34.2026.11.16.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:54:06 -0800 (PST)
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
Subject: [PATCH 5.10] selinux: prevent KMSAN warning in selinux_inet_conn_request()
Date: Mon, 16 Nov 2026 17:53:54 +0700
Message-ID: <20261116105355.89902-1-petrvaganoff@gmail.com>
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
index 6a94b31b5472..e5af391023ba 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -195,6 +195,7 @@ int selinux_netlbl_skbuff_getsid(struct sk_buff *skb,
 	struct netlbl_lsm_secattr secattr;
 
 	if (!netlbl_enabled()) {
+		*type = NETLBL_NLTYPE_NONE;
 		*sid = SECSID_NULL;
 		return 0;
 	}
-- 
2.55.0
