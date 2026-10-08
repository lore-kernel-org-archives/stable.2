Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6E412BF8
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459335; cv=pass; b=n3X4mfe2lnegjJ9br6ePTsAdb4zjOnoR9a3mzAwpqSn4pjvQCAYmE7cHqo4FJQumPscnmT3JYJI1mlpcrniohHMsL09oiJ/1nDS6qGc5vma1946N+uR3KA6T3uM38pC2Axiet778EFv33+vgypwUJCavEWTu9Znpu4OoSak3TpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459335; c=relaxed/simple;
	bh=qwS80d1Sq3GZmTtrcuSn4QH3WH9VVgg1Y27sZBwjsZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9pNFlG1TgoGVH/PUL/vb31QiCmRdEI3p0507UocsjzjfmGhLWhcdnUhFgrsUKfAC/ledUAUa2PuY9OFly/eQc28IgVuQ+UUUOqp1EDEzmmC4WcfvhcF6jsss6lHxyGjMWhPyfO06G23RokiMSuJinkdaVcKb9i7/ZM8IHA+xaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=gftZ58rR; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="gftZ58rR"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e608cd460eso11480565ad.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 04:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791459333; cv=none;
        d=google.com; s=arc-20260327;
        b=ltoaoRS3sOv3T9e21Q6FAaEL5PiLSa+31dfI866u2UZ/xTjHM1Ra8cqMn53cmuAPI/
         NSUFShHIWiqzIo3WvkJzppjCMslwUZ7Ud6BYFigcYRJ8LUEFk/yg0oLu25a1iVSuzqKf
         ykcXgK66cV+P7XORh2W2d+TYPSve+oU8le78cnKHmQRPeiKLqrqLz2pqPe29i1IPOdND
         xmYd+WyqPBP0YGSzulLvWcRWP2XHO+Tvl0X/NJthF7Qd34TC7ITHulcVNFR0Zo+86mbv
         In5SyLqc0no0VBfn9oE8KXbblJMbMPFY42F14NqpIE0dp9rUIwHSQdfdcJT0KlYMJckU
         pbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WJ0j6cOAzgWtBhqKOpMaIaa9HpzVeoPjmiPtw080gpM=;
        fh=yALumiJX1Ymsq6JnH8JCa4GUckqZUKpwNdmlYtdWQ0E=;
        b=j2e4Y2LnHnvc+bozAtlLMz3MV9pQF4T4UIAUtUZctcrRWB2lOst5J9h4rfUW0aogoe
         DqH/PWNBS5mEZ6VZjh3m+F7gxOtAwFQ8K7r5Z982baBMj4c32vh8rFINH4amZtg3oewk
         merEgx/GLbDW634+XYNxwdmTvrd5vCgfHxjRhelSQnJCfBlLsG1ykePXR6z19N5YsfMz
         EjJ1PL0oBqcBZBv3R6722eBza4786221F3QLdagykBT0hWjBIYp254L4w/XIIjG4Ho3G
         DM60suo+nJsy+j/75aVccWqjh7+3HmW974LisLRX/sbhCyjOcp9U46YWfTCRLrsnfUFV
         K68w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1791459333; x=1792064133; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJ0j6cOAzgWtBhqKOpMaIaa9HpzVeoPjmiPtw080gpM=;
        b=gftZ58rRoGgxYAhe/FtQZh1dcTPnEdH+TN2L0gEXc7m23OeyFfJpNQXJmFdIZe+KRi
         zJ23HbEsI7DOK0Q/o33dU/IIhhPwiRle9yp7tj7o3Vhf4twFcVq8Ng1kahSWPotI3jJQ
         Yv/wvg0wAk1tk7mPaUZiJ5UPBA0twGgWEPfzkYM9fFBa3L42nRxARrbeCyrt6KAn1O65
         u9gO5kqc78DrJJtGqAxnXOi6MoHKhsNdibo4u4Vc9DDMr/WpweRN8CO2s8jvSMIAbWXy
         3lEi5zbQGwu76BgGqFg6YmoWznorm0qdJLMADp8mBnTLmcnhvo1BkodEKz1hbq9RIYGt
         td4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459333; x=1792064133;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WJ0j6cOAzgWtBhqKOpMaIaa9HpzVeoPjmiPtw080gpM=;
        b=0zpc5WP1uYeNWeEiSPB2kStEVrMvDU3gW9UaN5y3e/RsE8K236y9H4ncct/1osVVnD
         WBm7uTtUh0tQ6Zkz3AwVD1JVR/nNh0ZlUIu2Fx2MbNrDgebltRn8exlZj8kjT8gtDs/i
         pMfZCagNN/hfRCvfZKiPor6Sl57uVa2cxWXFjLSFuIfT9kNVSlheUDK+52tRZ3oFzgaZ
         F7Z1hm4YxKZLwMBaG84PXi3shdTsPs1Xxw7sQLV3KMDIVbmaOJ8oV/DrZ27Re2ZrSZig
         HfHVEwuu3KONwa+cSmnvaAgGjtPiPGCbcpdFoI7hERUttaLtA00MUrMZaYZGXBVMemBj
         TSwA==
X-Forwarded-Encrypted: i=1; AKwUvByjH0Rf+WO+dKODlrnr/L3PDq0vLGJg2OjoOt2RiZwto/OdzJXHUhirHYr0yq/NIz/1lpXnuOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1mx+Spn8j8V6En5OjBTDk0qNj3Nj78MV47aldfXM2vcYOJ3fD
	Js5udCJuht+2+UftGM6oa7NwSf9lKb77MgKXthJuDHvfGddJLoS7TKKpFHoyrJYso6ssYVQDJ6E
	wAj27463waqBgHMzuTdbynHf9w6omDXYeMtxYiT9GoA==
X-Gm-Gg: AYBFou1miq0JrmNpZzeopJA8kp2QVKIOX3PVR6ntD8NPpJiEgrRK6kWwxeZrEAfFfY7
	y8uoMUD8gSJH0RuNFgGCXXYKkw+YYqhAil/Tldv4ot4P5d1VWvcIdnSUK24MlDqZ+ecxFrmJ/+9
	LO6whnA3OOLK3ClTY0/RI9u467DJJys0wMSmNHiN8hAgvoQgR/fdkjcbKf/RoSeBnWa3/OGXPfg
	FAMa75Ke4GhTJ6IcYVl/euOcjj6lnZTUiQDLgo9fVn6uAzqnUwpAiQqtrnCnTM6C7LkrZexmump
	cCD7+iG3sDs8ngkS1ELpRjqeMpfA95botxfz4KwtR36VlmakbmZ59pIWkqUGGIrBmd+ywz+0Xym
	0pk0TC7DxWJwubqm2yTjWvMwCuqBngD7wHrP6QSlEIskm6LxH6DQP1p1AHvHg7AqAvsuYxFroIk
	M=
X-Received: by 2002:a17:902:f78f:b0:2e8:b51:a94a with SMTP id
 d9443c01a7336-2e80b51ab89mr14161265ad.60.1791459332533; Thu, 08 Oct 2026
 04:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
 <a6193df2-98f3-409f-b73f-5b91835a0107@kernel.org> <CAL4WiirwF6bZwocErCthJ+TUu7wipRfSibRBoKWjjkA2nVSrqQ@mail.gmail.com>
 <CAL4WiiqSmW093PDngLrUNiNA5GVKeM3+tAO7KMDJeyjYZ7GRzg@mail.gmail.com> <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org>
In-Reply-To: <4c98eff5-c8c7-43ee-b59a-adb833978816@kernel.org>
From: =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Date: Thu, 8 Oct 2026 13:35:05 +0200
X-Gm-Features: AclHuK_tvli5e8RZKmXkQP-Qa8CuMz9cFdX9rYwTM6ujlWxZGIxES2B32YmtH_I
Message-ID: <CAPa5EdDk+HuVP0H1+iqOcHDHZnfdika5WOQcgSaMtfRFWzqZ+Q@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
To: Eric Dumazet <edumazet@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, nic_swsd@realtek.com, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

On Wed, 7 Oct 2026 at 00:00, Eric Dumazet <edumazet@kernel.org> wrote:
> Note to testers:
>
> My LLM agreed with the change in vlan_dev_hard_header() (above), but said
> that no change was needed in vlan_dev_hard_start_xmit() (below)
>

I'll need the patch applied to 6.18.y for testing, as I can't test it
personally and I want to provide testers with the same kernel/system
version as before just with minimal changes. So do I understand
correctly that the patch below is what you want to get tested, no
changes in vlan_dev_hard_start_xmit()?

Regards,
Jan

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 560521cf596e..67648152add8 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -49,42 +49,14 @@ static int vlan_dev_hard_header(struct sk_buff
*skb, struct net_device *dev,
                                unsigned int len)
 {
        struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-       struct vlan_hdr *vhdr;
-       unsigned int vhdrlen = 0;
-       u16 vlan_tci = 0;
-       int rc;
-
-       if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
-               vhdr = skb_push(skb, VLAN_HLEN);
-
-               vlan_tci = vlan->vlan_id;
-               vlan_tci |= vlan_dev_get_egress_qos_mask(dev, skb->priority);
-               vhdr->h_vlan_TCI = htons(vlan_tci);
-
-               /*
-                *  Set the protocol type. For a packet of type ETH_P_802_3/2 we
-                *  put the length in here instead.
-                */
-               if (type != ETH_P_802_3 && type != ETH_P_802_2)
-                       vhdr->h_vlan_encapsulated_proto = htons(type);
-               else
-                       vhdr->h_vlan_encapsulated_proto = htons(len);
-
-               skb->protocol = vlan->vlan_proto;
-               type = ntohs(vlan->vlan_proto);
-               vhdrlen = VLAN_HLEN;
-       }
+       struct net_device *real_dev = vlan->real_dev;

        /* Before delegating work to the lower layer, enter our MAC-address */
        if (saddr == NULL)
                saddr = dev->dev_addr;

        /* Now make the underlying real hard header */
-       dev = vlan->real_dev;
-       rc = dev_hard_header(skb, dev, type, daddr, saddr, len + vhdrlen);
-       if (rc > 0)
-               rc += vhdrlen;
-       return rc;
+       return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
 }

 static inline netdev_tx_t vlan_netpoll_send_skb(struct vlan_dev_priv
*vlan, struct sk_buff *skb)
