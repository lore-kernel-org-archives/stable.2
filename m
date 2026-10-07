Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2593C1D49
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395762; cv=none; b=cY439pnyCQDJho4tkGwsEybumxNKuimDhp/0ev7hXv9as2ICJwSSPpjrdPV4jr3Sx30JJ5GczrZ3huOohqxJzodo6AZn9XGJDDMjSrTMP5YyedmQo8z4sLig73hwNdKt+wUG1mi3f4TqYXa3J28bLnbcjsePXQZAx4jKYcRj7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395762; c=relaxed/simple;
	bh=A37dHJSUMP/nvKcIqGBinBiB2RmDmS9OMtLDSfYEGv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/M9aOnHUYm8zCQKSf2/sqEF66dAh3kR7FRVjeZlGWEZqUukr/JvG75nFc46qvTZ1lLZvjdEVWOOqdDpCUQlxXm00hoJVu5LlzLmx37fG4EYmK4aipo+EUEPKnI+QMVLiG73YI9n//EOieIo0ajpdjzRkCPKoQHqVavW5yjcz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=DPY+usRr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="DPY+usRr"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5338f65913dso46013201cf.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791395760; x=1792000560; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xmwkg4obehY78DK/gvFot3vkf85Y9oVRiaNJ/eUX4mE=;
        b=DPY+usRrPG8xvaf/hqKH98V5v7geHLSyZs17F0G33Yu8FaUo0ZuZtWBbpFKoor9xvl
         UFISfg7Sw809fVckekivoFtY+rjJi+T+Cmru0qX7ZSBqJSlXu3IF3My/tJAsm/isXZNM
         /vW6xK4X5NRQuNXcTHOBjJCCPujMmt4akKFoIM37KmWn0tJN9HNEn79laW/pN1y4McVY
         vhLwiebiSV9gJzDK6+7nCDpz5WL5/LMJ6cHVKUnY9meIyLk8RjT168CmjVSbAde6Jg8C
         CK4q1ov76TNLtS9TtbXKkJFbf8lgQ5F1k0SOWS0uplpCZXYlQIEMfPUbPVtXgOlOzwNu
         5CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791395760; x=1792000560;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xmwkg4obehY78DK/gvFot3vkf85Y9oVRiaNJ/eUX4mE=;
        b=baNvQ+z9gk4FqM772mQ6Xs2j5Y7md37fkZgGE7I3JhIC5IaUIe4PF19HXiQl3FvUSf
         GRHAvn9K/v2exUSa1J1BeofwutxMfcDMJeS9im6GPa3AaTQ4+3ngqCLPl+zBhkPFnxqD
         wLuQXn86PJkKlmJN2fPjStwyFUOXjc4KcELcVmDwl02dxhrrJzP7frF9EEDELhb+ceGk
         8TXfXeGmqn8c4a6piPOVfxV4uuUgCNxCp6ToY2GETp/Fi/NexkpM9mAvtTiVzULWFiv2
         T9FxJB3UESxL5mI8/Qn0GbVLZBmLl0oXi0DfyuVH/pSW6DudFWR+00Rga2hb/I/OoAaI
         gT9w==
X-Forwarded-Encrypted: i=1; AKwUvBx9hNxT/B6kM+n4DfHrXZyZ1ZwfukFBPwJo54CAW3bHbFixEyaNtiLoCLS+lN1Elof/HL3O2d0=@vger.kernel.org
X-Gm-Message-State: AFuF++ngD/56voD5fmuwKpzyREkh04/i3D5OI/ounojkQPGGB2Gym7Sd
	NoHldmDNngoPgVHwKoVQoWr+H8BpFCZNMhKxJRMYLtwOlQuxSbYZYuipZKLhOAyiEYfT9omOFvc
	qkhMX0zc=
X-Gm-Gg: AYBFou3LwUo0dkEsq2W5X9XzH57uOeycu3qIp9dOLAI8auB1h2qyk8yc1gG8PBUj7MU
	buw3NiX1WklUu41JkyEiILaero9V3M5nogRnXplyxpXTXcTP7kdLaVNnMEqW9j1LG2ow4bqgClH
	9tOVluYa72rCvJNthz4F7RMBYt1evZQZ14G1c7nSQM9MnmMNrp/OIGinl7WQrqcrWShsQPRrlAQ
	Fj7yNf/o77OdOuHq7AKdTKgCnEjmYXl5w5OTtl9RlzcUZNpRL5Eqbj4+ZpMMmu0za0zK5pcIMDz
	u2lng+4Ci+2llCkcc94dncmzDIGpPM/6zXbJtbmeN7Qq2PewgKurnfq46w0AYxp5MZdfKLDY8Lb
	Eueicwz05/nVfwtPfiepuhj1PuqQIvp17aGJFydVhuBP8ziRgAMaAizeNhZHRjo14Le9OXAW8Ay
	eGZQX05SqdC1ruGjy0hwx+ijyVO+peyBAcUrE7WMXRjogCsOnfVCp8XmaD9YHjaF2DyAAXCXbzy
	l7J2AZUaMxHuzM=
X-Received: by 2002:a05:622a:228f:b0:532:d202:3280 with SMTP id d75a77b69052e-53575587ed0mr53145321cf.17.1791395759016;
        Wed, 07 Oct 2026 10:55:59 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357211719csm25090341cf.16.2026.10.07.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:55:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:55:40 +0000
Subject: [PATCH net] xen/netfront: drop RX packets with a short Ethernet
 header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-xen-netfront-short-head-v1-1-12d7113a7e4e@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAJyHxmoC/3WNzQrCMBCEX6Xs2aVpiUF9FekhP1sTkaRkoxRK3
 92knj3Ox8w3GzDlQAy3boNMn8AhxRqGUwfW6/ggDK5mGMWoBiEUGokrRYxU5pxiQfYpF/SkHcr
 z5UrkalEpqIIl0xzWQ36HOoDpB/ltnmRL07aa0Uxoso7WN/RaeiP7A/45gn3/ApL5MHK4AAAA
X-Change-ID: 20261006-b4-xen-netfront-short-head-4589eed26166
To: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chris Wright <chrisw@sous-sol.org>, 
 Jeremy Fitzhardinge <jeremy@xensource.com>, Jeff Garzik <jeff@garzik.org>
Cc: xen-devel@lists.xenproject.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791395753; l=2871;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=A37dHJSUMP/nvKcIqGBinBiB2RmDmS9OMtLDSfYEGv4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBma8pM3Gytl7OfKxBBYVgGtx7BbS2eOhz5s1BtEXfNAHtDhR2In+nspjxyU+mEHrN5zQE+wIHz
 sHiMpR5ErGQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

handle_incoming_queue() pulls pull_to bytes into the head before
calling eth_type_trans().  pull_to is the length of the first RX slot,
capped at RX_COPY_THRESHOLD, and that length comes from the backend.
Nothing checks it against ETH_HLEN.

If the first slot is shorter than ETH_HLEN and more slots follow, the
head ends up shorter than an Ethernet header while skb->len is longer,
and eth_type_trans() BUG()s in __skb_pull().  If the whole packet is
shorter than ETH_HLEN, eth_type_trans() reads the header past the end
of the data instead.

Pull at least ETH_HLEN, and drop the packet if that fails, which also
drops packets too short to hold an Ethernet header.  This also checks
the return value of the pull, which was ignored.

Fixes: 0d160211965b ("xen: add virtual network device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
I found this reading the code while going through the callers of
__pskb_pull_tail().  To check it I ran a guest under QEMU's KVM Xen
emulation with QEMU's xen_nic backend changed to split some frames
across several RX slots.  Without this patch, a frame with an 8 byte
first slot followed by a second slot hits the BUG() at
include/linux/skbuff.h in eth_type_trans(), called from xennet_poll().
With it, frames with a 1-13 byte first slot arrive intact, frames
shorter than an Ethernet header are dropped and counted in rx_errors,
and ordinary traffic is unaffected.

There's a net-next series converting the other __pskb_pull_tail()
callers in drivers, including the one in xennet_fill_frags().  It
doesn't touch handle_incoming_queue(), so the two don't conflict.

Thanks,
Josef
---
 drivers/net/xen-netfront.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 2ed673649c48..d269457e839e 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1234,8 +1234,16 @@ static int handle_incoming_queue(struct netfront_queue *queue,
 	while ((skb = __skb_dequeue(rxq)) != NULL) {
 		int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
-		if (pull_to > skb_headlen(skb))
-			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
+		/* pull_to comes from the first slot's length, which the
+		 * backend controls.  Make sure the head holds at least an
+		 * Ethernet header for eth_type_trans().
+		 */
+		if (!pskb_may_pull(skb, max(pull_to, ETH_HLEN))) {
+			kfree_skb(skb);
+			packets_dropped++;
+			queue->info->netdev->stats.rx_errors++;
+			continue;
+		}
 
 		/* Ethernet work: Delayed to here as it peeks the header. */
 		skb->protocol = eth_type_trans(skb, queue->info->netdev);

---
base-commit: d5a007b9b457c915ab1a53227e8939e4018aa97a
change-id: 20261006-b4-xen-netfront-short-head-4589eed26166

