Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AC4195A0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341270; cv=none; b=pRYyUcZxa72xfmrZS/EPkLx7IWXJRz3CJPWddQiOdBNg09YFj2N4Izo/9Mp5qZwY2ZbqPzbNQr2t4a4LGOkR7JxWldnaGTx3zs6ZTzJKBVEbSMFVDx+oA49Kxrje8s+ED98ZKFQLmplJ4PzJ0fbqRU5pDzORrXKJQpswsY4vQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341270; c=relaxed/simple;
	bh=h/dQd4Jqh669dcKQjFfQ2tvPKkMsUHgb5Dzinm9LIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pX6kgcQCHJH2G5LlWbQgP5WlfS8sql1RAksAWYsESJ7ujRotXSW6Sef0kpUwbpndcj3OpHmNlmiiHDusW4/IkNPVQVLbVK0mmthMZHMMPKrRB4S4btzpUrm8eO6Gm2GDMnLGsbTwe8jDeECrS/D6hv7cfVMdVQLfcCIPvCa/TTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFwu+lV3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFwu+lV3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-85590c5aeabso725332b3a.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788341265; x=1788946065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YREt4HKo/yR3fmF2bs9ccnvMNqYMkkGFmZFuaSJ3xzQ=;
        b=fFwu+lV3WfpbgkUE6xlLOqhyUaRc+EOjb5hAy2xRuhwZ1E99V/u3qSeXGtfsfFIFaV
         d9vjUSrLGRuZ+0k0tS7ogCJIpG5zNNzsH69YvE5we4N8oPj+SMyEJsAHXnrUasIsyXnL
         aTO+txLNzIpGs+8gqi20MWoaq+0tGbxfczzy51yhumy0FvyXuoCO/J4O7sFERFPVq/b3
         5spYo7+k6P5u6s4qNanjl6+JvOhKiFaWaznv3zRA2OWiyTsqYU3ZNsTsEG5j4VuPDDGF
         lBt1JuKPJ7pgTCJpyRP7uI9DIFljYgX9xaYtJelugdu64rXoDq5rnJucGd1KfM69V/Bw
         2r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341265; x=1788946065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YREt4HKo/yR3fmF2bs9ccnvMNqYMkkGFmZFuaSJ3xzQ=;
        b=CSEDR+BBVh4xx7joJiU36/agYOx3hxvm/48ddHGTBiRbg5TUNOAOAFb10v2K2KUHn4
         YhvK5zhs8cmDoF9avNDMU15+qdoreQzJsup6ULKmwk6U1Pl4+ucqBZqKmnuQw80rZ1HP
         jNuBxHP9TBvTDVx249hOylI+3+oaXICpgu0ZsZEmKcCXR5XOOWTp32hQgc68l5fJVI3M
         mpre4NbbHuxmr2Hh1I0fBOIoOXB8WAh8Epcd2HjQF34OMt5AgiNRHlCe8q2afWnGlooF
         H53KfKkyJrL9OVVQsFryhB9jNL1q0Qjh2BcSj6Ahwe8asZ6ZW0tD6ceI/FlXPLNA1+Xz
         RQ1g==
X-Forwarded-Encrypted: i=1; AKwUvBzg/yi8raX1WiKpPaqcOHAunNB+GnawIEkoTH0zyUcqouAECfh03BXwhdLM55OpEv0hB7FU464=@vger.kernel.org
X-Gm-Message-State: AFuF++mBSy6nbEn43lAUfezsFFJBEsQV15yO/CbCLS28rifYWxJmsVUA
	qohberVMjzMQJdXLHzvWlnKtdcPR5V49VRsYRyoPXb2/faJaV7iV4185
X-Gm-Gg: AYBFou09FhopzO4IJfHIvjHz3USS0TeigByxBU9qFaTh/LWlTzZeNbyrJmDwJGM1bd2
	TX8B5oA+aeZa/9ebUZqATdS40VmFkA68fVOGhLkW5WfLMwHKYjD/xbyBHDoYqw0iYSRSSoQtGCQ
	P3LoV20D1xDH2vfxDU6GHeT4k/7cQ11Q0+t2DDwUWCYO/T0THwUGhJKFaliLcVMC4ymRq/eyoDR
	mVwp0P+i4h76yAX3z1wWD/LaDD2X6V+UGHxiMwC3u5AglrcupxAArS8juCa/3CyuX9NARFmFTmf
	GiHYa3lcczr9McPUzfQ9pZDiiJQQLgojkLEn/SbuIPg2GG9wizYNv6UP9pDhLfnk10u4VC0JrjG
	VepLe5BfGUVqBs6lDH0lEbXgOlX1u7G+bWFoCO+4Bm0zOC5VKOlI0/4VU6B3WojovwCKXPx+z9F
	kTwmZO4vgsrhc4M5KANXUekzG1IuHyybD6k9h+26ZqRhV4pCj0RkWVhOzbDx4EQtKUXA==
X-Received: by 2002:a05:6a00:368c:b0:851:c1d2:c48d with SMTP id d2e1a72fcca58-85ed25e0713mr5793959b3a.8.1788341264937;
        Wed, 02 Sep 2026 02:27:44 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0810a7bsm1051678b3a.47.2026.09.02.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:27:44 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Jiri Benc <jbenc@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Fourie Zhang <fouriezhang@tencent.com>
Subject: [PATCH net v2] net: mpls: clear inner_protocol when the last label is popped
Date: Wed,  2 Sep 2026 17:27:12 +0800
Message-ID: <20260902092719.2874481-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_mpls_push() records the pre-encapsulation network header once, gated
on !skb->inner_protocol. skb_mpls_pop() never clears that record, so it
outlives the encapsulation it describes.

Open vSwitch can then re-push MPLS onto a packet whose
inner_network_header still points at the older, deeper offset: push a
label, pop every label, recirculate (ovs_flow_key_update() re-derives
key->eth.type and resets network_header, but leaves inner_*), then push
again. ovs_fragment() trusts the record:

	skb->network_header = skb->inner_network_header;

so skb_network_offset() goes negative. The bound check is signed:

	if (skb_network_offset(skb) > MAX_L2_LEN)

a negative offset passes it, and prepare_frag() widens the value:

	unsigned int hlen = skb_network_offset(skb);
	memcpy(&data->l2_data, skb->data, hlen);

which is a ~4GiB memcpy out of a 30-byte per-CPU buffer.

Reproduced on v7.3-rc1. RDX is the truncated length, (unsigned int)(-8):

  BUG: unable to handle page fault for address: ffffe8ffffc16000
  #PF: supervisor write access in kernel mode
  Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:memcpy+0x8/0x20
  RDX: 00000000fffffff8 RSI: ffff888105d732db RDI: ffffe8ffffc16000
   prepare_frag+0x3df/0x4e0
   ovs_fragment+0x589/0x7e0
   do_output+0x4ce/0x5e0
   do_execute_actions+0x55d2/0x7b30
   ovs_execute_actions+0xea/0x450

Same root-cause shape as commit 975b5b067f52 ("ipv6: sr: restore network
header before routing and forwarding"): a stale network header offset
reaching a consumer that widens it. Here it originates in the MPLS
push/pop path.

Clear inner_protocol once the packet is no longer MPLS, so a later push
re-records the current header. net/sched/act_mpls.c is the only other
skb_mpls_pop() caller and gets the same fix; sch_frag.c saves and
restores inner_protocol around fragmentation in the same way OVS does.

Fixes: 48d2ab609b6b ("net: mpls: Fixups for GSO")
Cc: stable@vger.kernel.org
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
v2:
  - correct the Fixes tag (Jiri Benc)
v1: https://lore.kernel.org/netdev/20260902082924.2812968-1-fouriezhang@tencent.com/

A KASAN reproducer for this issue is available if requested.

 net/core/skbuff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..cc3b4b70288b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6690,6 +6690,13 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	}
 	skb->protocol = next_proto;
 
+	/* The last label is gone, so the inner header recorded by
+	 * skb_mpls_push() no longer describes this packet. Drop it, or a
+	 * later push keeps the stale offset.
+	 */
+	if (!eth_p_mpls(next_proto))
+		skb->inner_protocol = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_mpls_pop);
-- 
2.43.7

