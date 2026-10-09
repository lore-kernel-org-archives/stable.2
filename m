Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15564D1783
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552742; cv=none; b=AB4ogPyQi3XIVo8GV7/D/LolCNLOx/jLEixdI7PP7G6ItVNHufP6nBhSlh9eD32GSSAbzL3XsaXSVne/AbqX1c3dHvQZCBEE8q49xpqACrVAyNFHXwXvysgyxuajzojYZbpRL583GRb8cN7WiE/2npJNcRMaRhwI1MotBYUv4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552742; c=relaxed/simple;
	bh=X42x1RMDLY3+9M3NxCW7lU5Ve42b1Qkd8v0uhVtOe0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lfYXJjaVm3TgFwFS+wQc1yXV4BM1C78kC6+BhQffslRHR+gMh2dEvZxkh5ZzIsC1fr4Yzd4wmPfPA00nzZksadLLETQZLnKgpblhmjl25VreTv8BvphrCO7IMb8VP2DKrgkyZNg/0YOz6vaeXjEIUjiwK4Onc2U+uBMHiH1cuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZfUMgiOU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZfUMgiOU"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337fb43c16so42196371cf.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791552739; x=1792157539; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9Jl/7RcUeJpAm6kO/vJiIuIhdszw9gJvmu2v1BnzRms=;
        b=ZfUMgiOUZuzxi71uonYofCvhKlz/ZLaEXbpnX+7yJSlaTqeTSBqjcm0KGnoO3egOvr
         gjtPg7v/1coz6odoMs+3h9z5MK73ZkW3UnwwUw6NOzmipyio63sUh7rbYnR63hEL3loj
         ohJo2m3jeJKww0yUmvjg96xEO2DzSHWuAqU/6uFMZs6SU18+p83xBL/zpZxmbEDIi3Ia
         dA2TYVUrM9BOOwgIxIUOLiJkG8Mftz1O7tLRNfP/0rnqSLxnASo9C9ikoBwKTxgFr4/Q
         plr/bbwGUBSyfvSzCqHX+vc5BUWmlIgg1A5KK9ak14URleybvumaQS3bZ7JSTl1UHPyP
         AWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552739; x=1792157539;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9Jl/7RcUeJpAm6kO/vJiIuIhdszw9gJvmu2v1BnzRms=;
        b=ezmIK/S97tGpiXDeBe3RvbFqaTWyHrlJ+Sz1OSjkSMxmi2RU9++ZlWl1XZBiZjFLDw
         CNydlmJK5426O6Mrd4l/bAb17Ucm09xt22O9D29ShkXNto5D/wpVgbrNaesyfyR1SrFk
         YKWysLOB7FvG6/vD4hr1dYo7G9FWssBMrtaN/ZbPxI4fXgJofcVDvcER3MR7Xf0r6qf+
         ffm827J6EoJbRZ4kToz3hn0LjQzAeEAPhk3h3qaFBxBhMOhyjoLn2osYQBamqxALiAeG
         1iD5BFde2x+/tzvXCWFYBa/O69MRhfTm1hBBpNzKcAIb2GwvS8SMHtZoqFTniwQ2+fSk
         CB+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwlOSB0cysw/AMJaqZIks3cRPt7p1Y7z7Hk0otcRXPm63LRRGHWU0VPQ/i0Oc1oVrZyF9emDQg=@vger.kernel.org
X-Gm-Message-State: AFuF++k87EvuLzzXKoxMjV3xm8HdpSrNhoYcNK4R4mHWFTBDCzyc1Iot
	rs1hlRJ/6iaxkRLdA9nJ75KMdaWH1fFpMx+wNhtXWzNBayqmFFC70A/OpIxL5o2d6cY=
X-Gm-Gg: AYBFou2ZRx8BFjWOGaQ5XbwlmKFjRDqaKB/v2PwOHlqMSPYANe2+wql4HU65LVfVZLr
	oGB2hE2A4EZ8fT7RINN/leUX/EULzYndpg/2PXs/NlA6vkJwNtKbAvMTVJB0qZ68Seh/3p1F8Ur
	klYUuIuhk8ksVkGmyjluNA7zvetfb2xenXCi/2h5NObAFsF4vDiayzBsCCUkD35/rYe6jyYjHEo
	hL4b4UK0gMIneU0+ob45g4WXEne07iicejG7wzJhkEkJ9OCZ/lAoQ4Ye+YsKwFyDtg5ZkrqNXIk
	P+rXTOIV69urKuSkKzLcTCho/fLeJGpDaiYVC7t5WPS+wFA4x8SHRT875INc1Tg/NNX3Ga1QCUs
	HlEHjGzz75LEGc8DhufZHZcEW8II1EISu8ogMY30XTWgcwdUZMzfpFqweuBmCZJBqI3GjgZIG6N
	t3q2HeNvU3Ze2POC/gHNwlIAp1Y7e5t5PuMSsoVWKHvVKmNRr/aR+e5XStxvBbVOnSYldJVYRYt
	pbwhpzEfLD7AVk=
X-Received: by 2002:a05:622a:5812:b0:535:a5fb:6459 with SMTP id d75a77b69052e-535a5fb69dcmr16683661cf.68.1791552738520;
        Fri, 09 Oct 2026 06:32:18 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7fe4b9sm18233371cf.31.2026.10.09.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:32:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 09 Oct 2026 13:31:51 +0000
Subject: [PATCH net] net: skbuff: don't segment unreadable skbs without SG
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAMfsyGoC/32Nyw6CQAxFf4V0bQMzwUf8FeOiHQqMYiFTMCaEf
 xdw7/Ke3Jwzg0mKYnDNZkjyjhZ7XYc7ZBBa0kYwVusGX/iTK4oLcon2ZDRpXqIjam8NTpqEKuJ
 OkOjoz0Ecu7KGVTIkqeNnD9xAZYT7D9rEDwnjpt5uTCbIiTS0G+qGnMt8h39isCxfyE0P3sAAA
 AA=
X-Change-ID: 20261008-b4-skb-segment-nosg-unreadable-aa527ce1b14f
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791552729; l=3823;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=X42x1RMDLY3+9M3NxCW7lU5Ve42b1Qkd8v0uhVtOe0o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJU6oJpA2gw5aKuiASIUkJ6fCUXXhBA2Jcw71rLMgekOkppyvgUhxu0fSq6UzoKnevOyl17rNvd
 FIsl5GZY5Hg4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Without NETIF_F_SG, skb_segment() copies each segment's payload out of
head_skb.  With checksum offload it uses skb_copy_bits(), which fails on
unreadable frags, so skb_segment() errors out.  Without checksum offload
it uses skb_copy_and_csum_bits() and keeps the checksum that returns.

Since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
skb_copy_and_csum_bits()") that copy zero-fills whatever it can't read
and returns 0, which is the correct checksum for zeroes.  A devmem TCP
skb keeps its whole payload in unreadable frags, so every segment ends
up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
checksum over it, and the peer accepts the zeroes as stream data.
Before that commit the segments carried uninitialized memory with a
checksum that almost never matched, so they leaked but were dropped.

This is reachable when both SG and TX checksum offload are turned off
on a device used for devmem TX.  sk_setup_caps() still gives TCP SG and
HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
lets the skb through for a NETMEM_TX_NO_DMA device or a matching
binding, and software GSO then segments it with neither feature.  With
only SG off the copy goes through skb_copy_bits() and is already
refused, and with only checksum offload off the segments keep sharing
the frags.

Refuse to segment unreadable skbs without SG, which is what the checksum
branch already does through skb_copy_bits().  Check the frag_list
members as well, since their payload is copied the same way.

This was found by the Sashiko AI review of that commit.

Fixes: ab9414ed70bd ("net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()")
Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Link: https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Follow-up to Sashiko's review of ab9414ed70bd:
https://lore.kernel.org/all/179148235783.434549.14322374227477832817@kernel.org/

Tested with a module that hands skb_segment() a TCPv4 GSO skb whose
3000-byte payload sits in an unreadable frag, with SG off.  Without this
patch it returns three segments with all-zero payloads and a checksum
of 0; with it, -EINVAL.  The same skb with checksum offload was already
refused, and a readable skb still segments and copies normally.

Thanks,
Josef
---
 net/core/skbuff.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 41beaf625421..4ba544b5f3ba 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4782,6 +4782,18 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_segment_list);
 
+static bool skb_segment_unreadable(const struct sk_buff *head_skb)
+{
+	const struct sk_buff *iter;
+
+	if (!skb_frags_readable(head_skb))
+		return true;
+	skb_walk_frags(head_skb, iter)
+		if (!skb_frags_readable(iter))
+			return true;
+	return false;
+}
+
 /**
  *	skb_segment - Perform protocol segmentation on skb.
  *	@head_skb: buffer to segment
@@ -4842,6 +4854,14 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
+	/* Without SG every segment's payload is copied out of head_skb, which
+	 * can't be done for unreadable frags.
+	 */
+	if (!sg && skb_segment_unreadable(head_skb)) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;

---
base-commit: 6785011f8b16abf40b1e9d8b2e332232b3e68822
change-id: 20261008-b4-skb-segment-nosg-unreadable-aa527ce1b14f

