Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581502;
	b=fSsUJ3E6Uu+hUFCYZGfKuk6FqPv14v2Qge22lxJtbAHiVcHwCGcG78ZnRSPsyFoe5c3d
	 PP/6gyKy7+V3nFX5NZ8njpBiZGShGG8ayprez5z574XdGW4wUsSrbT16qDjeH4IbNmXqF
	 yg5YWSoNf6jEc4PTJYUNshu5K4lWyxn6Q643954SQGvnlGET6L7MjcJyPo5kuJ8xFkU8F
	 tQIFEJuNLwdLvV2w9mjUuDkorzgMqjDTui+kS7CjYe+bIdUTngAyyLOAW16jQBSGI3npR
	 MfmfKXB6wGhq3Xlz7EiNIBXdTyscvX80vzBsoefjetAMPO6ooRxSg1CbxatD7lYMojw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/XzU858PVVYWx9ArqiKeFW35VjWV+s75oIaXtUyhULY=;
	b=CClsGbYvPI3i4smxwI/tbWeNWyOSNCVgEh9m+f7KujQ7zw/FCglw463xtJKnVUVz0J4R
	 8tuHyKraGaleb6MAlq67MANv21nripE/c13ri1Uhlvdo4Ptk24mtG4GYzijLTV59dsvI2
	 xAZ0o7pzEDxXTDvJuM80U1c8UIR/cgPvpmNa/CwBZ5bPg7kO3QBY6IrJRsxltXbFSoPzf
	 +CnH0x9Sd+VKGjkva72GkiSWcE0oNX0WSXH4vH//FS3E5JbzfHpfsFgMyhkh3y0d5+TaN
	 8hNGF4FaHF2ESSnzmGoWIhWVmUvfh4x1n4gqI3tzVc0RGjPGKY1o76nt/9iW1TW59MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=iyObN45M;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4F606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF4F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=iyObN45M
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so2633762a12.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795581496; x=1796186296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/XzU858PVVYWx9ArqiKeFW35VjWV+s75oIaXtUyhULY=;
        b=iyObN45MJgSxqtlageqtgYM5837oiaIJ5+bs0qPevJBMaCNHqUnWeShu0jRy5dmA0j
         5mGfFnENTfbpmsauuhF6jVGaSZjj0lqeDdiPTX1woD3jiAf5uRd09IFuo1ACxoziIZns
         haiRHfYJ2i3O2KrAaRW6U9bsR5Y2HPCJHyUCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581496; x=1796186296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/XzU858PVVYWx9ArqiKeFW35VjWV+s75oIaXtUyhULY=;
        b=zdi0UyBEb6y0pW4hWodAnoXGi6IAQQV9i4kBWErUW8ikXAB5zdJ7z1pfBW9cXmk/1h
         N6Ztaeu86uQzEz6+zdG0lmENPcH6mzA/6JyXrz6+1Vuh+/oulfuLXd+DQ+F51ur1rQh+
         o3Utt/90eCTN41er4x2HujIrHlCpPKyCZKSgXC22uaYKj69kE98ToXEDbyUx5ERbS2kB
         dJyiGxHXLn4qXA2C1l/jSDd6wnFJ15OiIhw2cz+k73JY/c6ajwbolakVz3rOv0N3lDZN
         ZHYQ7p3bixReZhqBYgZgBGhc90TodhZsSZIdo+9QUaf4g5e0gYp+hQY8JvYk4vySKK5f
         jV/w==
X-Forwarded-Encrypted: i=1; AL+hErHqD0b7yeZvSPeJBc4IpwtAt1RR6VtqJ1Tu5PtXLZHKpes70Rte8pRhIVqAXkB1xW6n3qy54fc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TigLPAwrUUJqD1aRg3KJOVo96eNCItKg3vYbqKWq9r63FkNyz
	Cp0kCHzJQPJmAra/W4gjcvoQawBgzUwjxgJPx0MQCbcbAZ65viRw4wV7AKN8lIPeDerAKgBz/xl
	nmh8ISE1Low==
X-Gm-Gg: AZFdTZfswNmMsC1lyTh2MKuShXvRPtU81L2UN4WGyh/o3WWL55YmraaWaH6bgursWpT
	gYOzgBXGdHXiU8vKFjC4h3M7HUZ772o+OnFcyEE9bFyf5sCw2ndkHocfo3b3zKHaH5XG9NyibS+
	3HQ6WxcwjKMew/nUZgJjLH5o/fIPrIuynaq+bZYRyTRNfxdFXHR6h03TrW8l5jzdDMJwaxGDjwh
	cQwNDObXcfdl2F2qQBaeF/98Zb7hT1GkREC+npNAX6G2hLuNfrF8Ko/n6Uz5CcQQs+Bw59ksezl
	ruxsfXfnGTCLwo2dLkM0lvWZzxQvRHJkzw1NAj2m2BsC/EY2fWud1+ApQl3TdNfv+FOnHH6PmXB
	/5UKmDLgJ7y5zkah1ydPiQNeHdXFpnxvBGLttk5g8rL0dtOfgOnysRm01WMDA/UXnOXJd0FcFxy
	mvhqB4On5hEbevbt6AqWhC0t0QYXRHABMAg2a1MES2CbCNDtM3NhmqSMQYIKxKvnaOht54ziAiC
	JDjdAN40QHYK1TwUTOUZoqNl7bAJTEB4jOWMQTgS09saLpoFbjigPBaLsEeciYAdelGm/zZHNgT
	VHEMOFoIt5Sj5ajdn0R9+Rc2HZe2zUUGIljY3TS2GMO/4KBuYUkqY+BovDsHJZaJIHCLQ71p7YA
	ifSj4y5skHUzbYGuUkgbgVAjES4zT2hzkMcTOXN1W5OIRof8Jo+yfDxhxxck1mFWn
X-Received: by 2002:a17:90a:d2c7:b0:3b4:a90:7f3a with SMTP id 98e67ed59e1d1-3b41c95da5bmr15165176a91.55.1795581496295;
        Tue, 24 Nov 2026 20:38:16 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b703530sm10736254a91.1.2026.11.24.20.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:38:15 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: mac80211: do not copy the mesh RSN IE twice into the beacon
Date: Wed, 25 Nov 2026 10:08:11 +0530
Message-Id: <20261125043811.884090-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179557011763.3135.4931211502666684623@kernel.org>
References: <179557011763.3135.4931211502666684623@kernel.org>
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

You are right, and the Critical one is right in the way that matters most:
the patch added a second route to the overrun it was fixing, reachable
without any vendor element at all.  Thank you for catching it before it went
anywhere.

All three points were checked against wireless.git at af6737b90668.  v2 of
this patch is posted as a separate thread:

  [PATCH wireless v2] wifi: mac80211: do not copy the mesh RSN IE twice
                      into the beacon

Only this patch is respun; 2/2 drew its own review and is answered in its own
thread.  The v2 changelog is under the --- line, with a Link: back to this
posting.

Point by point.


1. [Critical] Can prefix end up larger than ifmsh->ie_len?

> So it returns pos > ielen whenever ielen ends in the middle of an element.
> That can happen because ifmsh->ie_len is still a u8 in struct
> ieee80211_if_mesh, while the policy allows NL80211_MESH_SETUP_IE up to
> IEEE80211_MAX_DATA_LEN (2304) bytes

Yes, and every step of that holds.  Checked in order:

  ieee80211_ie_split_vendor()   net/mac80211/util.c - advances
                                pos += 2 + ies[pos + 1] while pos < ielen,
                                so a length that ends inside an element
                                makes it return past that length.
  struct ieee80211_if_mesh      ieee80211_i.h:829 - "u8 ie_len;".
  struct mesh_setup             cfg80211.h - "size_t ie_len;".
  copy_mesh_setup()             cfg.c:3449 - "ifmsh->ie_len = setup->ie_len;",
                                size_t into u8.
  the policy                    nl80211.c:10888 - NL80211_MESH_SETUP_IE is
                                NLA_POLICY_VALIDATE_FN(...,
                                IEEE80211_MAX_DATA_LEN).

and the write lands exactly where you say it does:

	bcn->tail_len = skb->len;                      /* mesh.c:1109 */
	memcpy(bcn->tail, skb->data, bcn->tail_len);   /* mesh.c:1110 */

bcn is kzalloc()ed to the PRECOMPUTED tail_len while bcn->tail_len is taken
from what was actually assembled, so anything the emitters put in the builder
skb beyond the budget is copied past the end of that block.  Your 257-byte
example is right: a 255-byte RSN element leaves ifmsh->ie_len at 1, the
unclamped split returns 255, and 255 bytes go into a one-byte budget.  My
commit message asserted "the split returns an element boundary that is not
past ifmsh->ie_len", and that assertion is false.

> Would prefix = min(prefix, ifmsh->ie_len) fix this?

It does, and v2 is exactly that:

	prefix = ieee80211_ie_split_vendor(ifmsh->ie, ifmsh->ie_len, 0);
	prefix = min_t(size_t, prefix, ifmsh->ie_len);
	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, prefix);

Two things make it sufficient on its own, and the commit message now says
both rather than leaving them to be rediscovered:

  - the clamped bound is never wider than ifmsh->ie_len, which is the bound
    this search had BEFORE the patch narrowed it.  So whatever ifmsh->ie_len
    happens to be - truncated or not - the patch cannot make this copy
    bigger than the unpatched code's could be.
  - cfg80211_find_ie() returns only an element that lies wholly inside its
    bound: for_each_element() requires sizeof(*elem) + elem->datalen to fit
    in the length given.  So len = 2 + data[1] cannot reach past the bound
    either, and the skb_put_data() fits the budget.

> It would also need either ifmsh->ie_len changed to a size_t, or
> NL80211_MESH_SETUP_IE capped in the policy at what mac80211 can store.

Agreed that the truncating assignment is a bug in its own right - a
configuration is silently stored with a length that does not describe the
blob - but v2 does not need it fixed to be safe, for the first reason above.
I have left it out deliberately rather than widen a struct field inside a
patch whose subject is the double copy.

> The follow-up commit "wifi: mac80211: widen the mesh IE offsets a u8 cannot
> hold" doesn't appear to fix this. Its commit message says "ifmsh->ie_len is
> a size_t", but the field is still a u8 at the end of the series

Also right, and worse than a wrong sentence: that patch widens the LOCAL
variables in mesh_add_vendor_ies() and mesh_add_rsn_ie() and does not touch
the field, so the message describes something the series does not do.  It has
its own review and I am answering it there; whichever of the two remedies you
prefer - the field to size_t, or the policy capped - belongs in that patch
rather than this one.


2. [Low] The wrong netlink attribute

> Is this the right attribute? nl80211_join_mesh() doesn't seem to read
> NL80211_ATTR_IE.

It is not, and it does not - nl80211_join_mesh() has no reference to
NL80211_ATTR_IE at all.  The blob is NL80211_MESH_SETUP_IE, nested inside
NL80211_ATTR_MESH_SETUP, stored by nl80211_parse_mesh_setup() at
nl80211.c:11071 and kmemdup()ed by copy_mesh_setup().  v2 says that, and as
you note it is not pedantry: it is that attribute's policy that admits
IEEE80211_MAX_DATA_LEN, which is the half of the Critical issue the u8 then
truncates.  The reproducer in the report thread sends the right attribute;
only the prose was wrong.


3. [Low] The peering frames

> mesh_plink_frame_tx() in net/mac80211/mesh_plink.c also calls
> mesh_add_rsn_ie(), so this patch changes Mesh Peering Open/Confirm frames
> as well as beacons. Should the commit message say so?

It should, and v2 does.  mesh_plink_frame_tx() calls mesh_add_rsn_ie() at
mesh_plink.c:287, right after the extended supported rates, and
mesh_add_vendor_ies() at :349, at the end of the frame - so for a
configuration with an RSN element behind a vendor element, that element used
to appear twice in peering frames too, and now appears once, in the trailing
vendor block.

> and explain why it is fine to move the RSN element out of the standard
> element order?

The argument v2 makes is the narrow one.  Element order in a management frame
is not something a receiver may rely on: 802.11 parsers walk elements by id,
and mac80211's own do.  The alternative is to keep the in-order copy and
accept the duplicate, which is the bug.  And the only configurations affected
are those that put an RSN element behind a vendor element - the ordering in
these frames was built around the RSN element coming first, and such a
configuration is untouched.

If you would rather the element kept its position and the DUPLICATE were
suppressed instead - have mesh_add_vendor_ies() skip an RSN element it finds
in the vendor range - say so and I will respin that way.  It is a bigger
change than this one and it makes the vendor range no longer verbatim, which
is why I did not reach for it first.


Thanks again.  The Critical one was a real defect in my patch and it is the
kind that the commit message's own confident sentence was hiding.

pw-bot: cr
