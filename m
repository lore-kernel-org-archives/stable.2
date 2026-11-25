Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581500;
	b=Uv3WFnvSCh/6vEsqlfG4NA3Astti3TX4U3MhrquEZrB68L3oGSTKhOGJmDpzV5Twq+zN
	 Hg2IbZu8Elb/5/O5ed0PFThu2CBVrrEzb5BAfqFMP34zvmQTBlSKKaz622OgIvPvjyc1W
	 u2HuHxyBBQrcoHDwxptZhIT59ShyFKtVatUlmcsJe8HlGW/+uzApACRU44TY+vuPvPrE7
	 9HMlzpLNpQyG3cW5oeum1g9QqOIXNtNZ2LgY41zlTZfKHkG8V8XMlIwG0QBNCGpC5K2zl
	 DokV9Qd3iWGZ/sTVVWOvaKUKCZtTeNvlbjDccb0Roz1JvZykTMg/1qP2AzibBTGqabQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UstZVkNfG9M8ON4DvEUF4Bp0cm0chz64PPbrwu3nxEg=;
	b=Blf+d7pn8AxCCvLvXuyUzfzOKrdVtCUY7qtB3rt14Jw2SXoUVKf9SBs5BrVo/wpxoOHe
	 JgUOqnBH9YeqffImyGwXXNJ8QHur9PFUMBECnyMSni/Ye/aAfbA4gAqle0uq75AaBrt+N
	 IW8EK9la/EZPrGPDNTv9yLuKUsyuDFx7jTmvBiWffTUw+amgW41VYPaIoBWcatBAVAbN5
	 RHWJCimFLEUSSrFVf6JBdAgbEuctXxfD/dbnuhXSX0Z+fnk13DfA1VijCR3RST3RbjvCp
	 05VosgaTR4DluZp9y1jkKSWY0hO8Z0gQ92N0IfuCUOslqR6oM3HjPhX2zbtRztWRMmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Op4m8DPe;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC5606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ABC5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=Op4m8DPe
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f0426a65e0so33688925ad.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795581491; x=1796186291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UstZVkNfG9M8ON4DvEUF4Bp0cm0chz64PPbrwu3nxEg=;
        b=Op4m8DPe/Y1pt97LAG3LtYi/WEkx9jRIBBIzCSWuxxkYCUfqlDvme15EoeEAb+inqT
         UWN4qJRHo4NtlsIsR0oABmKPRwiuNUAOKCOvvSEUmBUYGzY8A94odTtZxKBm4wo9UUpI
         j1TF/w3mbNta3KXQ3vojbWKCUyjBOGfNK8XMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795581491; x=1796186291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UstZVkNfG9M8ON4DvEUF4Bp0cm0chz64PPbrwu3nxEg=;
        b=b6fCN+O3fV70x1CtKA+Fzc2nW/QUvZDl5JmlR+FO2JmpxL/ZrkdSH6RxZpfsnSJTAJ
         BQ/0zkeG03//ZvISJnLuKHQhHrXfm69hq1wwMk/fyMy7txUTKlcCE77V+ZXChAxNNCAt
         cTeZu/r5SWTeu7yuM3Xt+N00TcZ2kUNdyJmQZCGahyRVMpbsfJyH4sIjvyr8osYInvZx
         W+shlrq7CKW+CtY2obvM/wsfG9mxW7EIyGT2jQnqIc2/xHFquUNiLpZfaJn2JnlC2PhT
         JSqVvvNbSmnHQRULoqCKOnPaqsVCbpJ3A2R+kWy5CZVeF/kokkspn7/bvXSnGaAzspCm
         QLzw==
X-Forwarded-Encrypted: i=1; AL+hErGq+cYvaFlHTqxPp1BrM1Lh/AqMZ5UFDKheXUkm8XUByf54BT3ox1+2hSyNZS/iIyDbHophL6c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lsFGlsiD58BlMYkRoDUrnqfQ8onplNGsa6iIUvYt/oQv/ShY2
	G6ZLIfgzhXda4xEXKtrpqRr9IjiiCxYamGhTDDBffLnqtvhaY5L2VPAab0gxhuP2KEc=
X-Gm-Gg: AZFdTZc9l8nJni7yhA90sfm1G++E2Zly83y7TDuZnmdtbWSne+nW6g9t0m13am+azBo
	qxYRRxQhttr014vkz9K//x7/qLayxCyog80cgKxbOfN7pUWH/qX+EAsfc9EGzUNn1g8it5NzDcM
	pPjP9v15zFcMrO19BPdAYd+qQWyTteRhxfSrGgaa6KuyQiMMwSwbEjKrzvF/oVDHH7kpGYbaEE9
	6Tsv8qNKH58azfvu1n6NHKVgS98VsEbnQuDqFc/Z4v0Oq4+8adNEr+ubLbEkepMmYZ0apV3ZxPK
	oCGdgoetontAErJwieNh6FJ1y44i21c+X2c0Lu1NVQ7PgxrOYhxu50V2nfWlbHqx0xScb8k4kIh
	tUA3cr+kFL5qP27ZEeT8MQsiZBvVeHIHwmpEaOdOlcKkpJvi4XYV1zd85jCr5Kaq/pC3hw0V927
	rNgFeMcsWnlAEa/QfT2rmOVjO5eTofC9Kpi9XVi1xFEXxZ4bKs/kj6Eo3Gniigmoss8ie3C18tg
	8m65xJYdLQg1yA5rbalWvRGwgkrDITWJSEKngs6px3WLTckfvUKpkFUJ5NZPlr+CK+puGoFLm2H
	oLWGs0m5sahgsP4BSL/tzXtHIQ5o86kyysEhw6g+8zAFtntKPSSLqoKWul3JtNMDhb7BwxTAqw8
	sgDTrxI3THtUIjaprUR60rH4jewHBm/smD+qeZvG7SwBNfnkf4G9jlrC7WtxDbLL6
X-Received: by 2002:a17:902:e802:b0:2ef:d9b8:469 with SMTP id d9443c01a7336-2f03f21e8b9mr153010385ad.43.1795581490808;
        Tue, 24 Nov 2026 20:38:10 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm78706445ad.58.2026.11.24.20.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:38:10 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] wifi: mac80211: do not copy the mesh RSN IE twice into the beacon
Date: Wed, 25 Nov 2026 10:08:05 +0530
Message-Id: <20261125043805.883952-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
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

mesh_add_rsn_ie() searches the whole of the user's mesh IE blob for an RSN
element, and mesh_add_vendor_ies() copies everything from the first vendor
element to the end of that blob verbatim:

	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, ifmsh->ie_len);
	...
	skb_put_data(skb, data, len);

	offset = ieee80211_ie_split_vendor(ifmsh->ie, ifmsh->ie_len, 0);
	...
	skb_put_data(skb, ifmsh->ie + offset, len);

So an RSN element placed BEHIND a vendor element is copied by both, while
ieee80211_mesh_build_beacon() reserved room for one copy:

	tail_len = ... + ifmsh->ie_len;
	bcn = kzalloc(sizeof(*bcn) + head_len + tail_len, GFP_KERNEL);
	...
	bcn->tail_len = skb->len;
	memcpy(bcn->tail, skb->data, bcn->tail_len);

The builder skb is allocated separately and rounds up to a kmalloc bucket,
so the skb_tailroom() checks pass; bcn->tail_len is then taken from what
was actually assembled, and the memcpy writes the excess past the end of
the kzalloc()ed block.  KASAN reports a slab-out-of-bounds write in
ieee80211_mesh_build_beacon().

The blob is NL80211_MESH_SETUP_IE, nested inside NL80211_ATTR_MESH_SETUP,
which nl80211_parse_mesh_setup() stores and copy_mesh_setup() kmemdup()s.
One NL80211_CMD_JOIN_MESH carrying a vendor element followed by an RSN
element is enough.

Search only the part of the blob that comes before the first vendor
element, so the two emitters cover disjoint ranges and their combined
output fits the budget.  An RSN element behind a vendor element is still
emitted, as part of that verbatim vendor range.

The bound is clamped to ifmsh->ie_len, which matters and is not belt and
braces: ieee80211_ie_split_vendor() advances one whole element at a time,

	while (pos < ielen && ies[pos] != WLAN_EID_VENDOR_SPECIFIC)
		pos += 2 + ies[pos + 1];

so it returns a position past ielen whenever ielen ends inside an element.
That is reachable, because ifmsh->ie_len is a u8 in struct
ieee80211_if_mesh while NL80211_MESH_SETUP_IE is policy-capped at
IEEE80211_MAX_DATA_LEN, and copy_mesh_setup() assigns the size_t length to
it:

	ifmsh->ie_len = setup->ie_len;

A 257-byte blob holding a 255-byte RSN element then leaves ifmsh->ie_len
at 1, and an unclamped search bound of 255 would copy 255 bytes into a
one-byte budget - the same overrun by another route.  With the clamp the
bound is never wider than the one this search had before it was narrowed,
and cfg80211_find_ie() returns only an element lying wholly inside its
bound (for_each_element() requires 2 + datalen to fit), so the copy fits.
The truncating assignment itself is a separate pre-existing problem.

This also changes Mesh Peering Open/Confirm frames, which
mesh_plink_frame_tx() builds with the same two helpers - mesh_add_rsn_ie()
after the extended supported rates, mesh_add_vendor_ies() at the end.  An
RSN element behind a vendor element used to appear twice there as well,
once in order and once in the trailing vendor block; now it appears once,
in the trailing block, after the Mesh ID, Mesh Config, MPM, HT, VHT, HE
and EHT elements.  Element order in a management frame is not something a
receiver may rely on - 802.11 parsers walk elements by id - and the
alternative is emitting the element twice, which is the bug.  A
configuration that puts its RSN element before its vendor elements, which
is what the ordering in these frames was built around, is unaffected.

Found by AI-driven fuzzing built on top of syzkaller, and reproduced on
mainline 7.4-rc3 and 7.3.1 with a 72-line program: one interface in mesh
point mode, one JOIN_MESH whose NL80211_MESH_SETUP_IE holds a vendor
element followed by an RSN element.

Fixes: 2b5e19677592 ("mac80211: cache mesh beacon")
Cc: stable@vger.kernel.org
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
Link: https://lore.kernel.org/all/20261124003526.78471-2-piyus@iiitd.ac.in/

This respins 1/2 of the v1 series only - the one this review covered.  2/2
("wifi: mac80211: widen the mesh IE offsets a u8 cannot hold") drew its own
review and is answered in its own thread.

Changes in v2, all from the review of v1 1/2:

 - THE CLAMP, which is the reason for this respin.  The review found that
   v1 added a second route to the very overrun it was fixing:
   ieee80211_ie_split_vendor() walks one whole element at a time, so it
   returns a position past the length it was given whenever that length ends
   inside an element, and ifmsh->ie_len being a u8 assigned from the size_t
   that NL80211_MESH_SETUP_IE carries makes that reachable.  A 257-byte blob
   holding a 255-byte RSN element leaves ifmsh->ie_len at 1 while the search
   bound became 255, so 255 bytes were copied into a one-byte budget - no
   vendor element needed.  v1's claim that "the split returns an element
   boundary that is not past ifmsh->ie_len" was simply wrong.  v2 clamps the
   bound to ifmsh->ie_len, which restores the bound the search had before it
   was narrowed, and the commit message now says why that is sufficient:
   cfg80211_find_ie() returns only an element that fits wholly inside its
   bound, because for_each_element() requires 2 + datalen to fit.

 - The right netlink attribute.  v1 said NL80211_ATTR_IE; nl80211_join_mesh()
   does not read that attribute at all.  The blob is NL80211_MESH_SETUP_IE,
   nested inside NL80211_ATTR_MESH_SETUP, parsed by nl80211_parse_mesh_setup()
   and copied by copy_mesh_setup().  That matters beyond pedantry: it is the
   NL80211_MESH_SETUP_IE policy that allows IEEE80211_MAX_DATA_LEN bytes,
   which is what the u8 truncates.

 - The peering frames.  v1 did not mention that mesh_plink_frame_tx() builds
   Mesh Peering Open/Confirm with the same two helpers, so this patch moves
   an RSN element behind a vendor element out of its usual position there
   too.  The commit message now describes that and says why it is acceptable:
   a receiver walks elements by id, and the alternative is emitting the
   element twice, which is the bug.

Not changed here: the truncating "ifmsh->ie_len = setup->ie_len" itself.  The
review is right that the follow-up patch does not fix it either - it widens
local variables in mesh.c, and its commit message's claim that ifmsh->ie_len
is a size_t is wrong; the field is still a u8.  That is answered in that
patch's own thread.  This patch is safe without it: the clamp makes the bound
no wider than ifmsh->ie_len whatever ifmsh->ie_len happens to be.

Measured, and not: the original overrun was reproduced on mainline 7.4-rc3
and on 7.3.1, and KASAN reports a slab-out-of-bounds write in
ieee80211_mesh_build_beacon().  The route the review found - the truncated
length with no vendor element at all - has NOT been run here; it comes from
reading the code, as the review's does.  mesh.o builds clean and checkpatch
--strict reports nothing.
---
 net/mac80211/mesh.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 8f8814125375..c86be97bc921 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -377,14 +377,32 @@ int mesh_add_vendor_ies(struct ieee80211_sub_if_data *sdata,
 int mesh_add_rsn_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	size_t prefix;
 	u8 len = 0;
 	const u8 *data;
 
 	if (!ifmsh->ie || !ifmsh->ie_len)
 		return 0;
 
+	/* Only the part before the first vendor element: mesh_add_vendor_ies()
+	 * emits everything from there to the end verbatim, so searching the
+	 * whole blob here makes an RSN element behind a vendor element be
+	 * copied by both, and ieee80211_mesh_build_beacon() reserved room for
+	 * one copy.
+	 *
+	 * CLAMPED, because ieee80211_ie_split_vendor() walks one whole element
+	 * at a time and returns a value past ifmsh->ie_len when the length
+	 * ends inside an element - which ifmsh->ie_len being a u8 truncated
+	 * from the size_t the netlink attribute carries makes reachable.  With
+	 * the clamp the bound is never wider than it was before this search
+	 * was narrowed, and cfg80211_find_ie() only returns an element lying
+	 * wholly inside its bound, so the copy below still fits the budget.
+	 */
+	prefix = ieee80211_ie_split_vendor(ifmsh->ie, ifmsh->ie_len, 0);
+	prefix = min_t(size_t, prefix, ifmsh->ie_len);
+
 	/* find RSN IE */
-	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, ifmsh->ie_len);
+	data = cfg80211_find_ie(WLAN_EID_RSN, ifmsh->ie, prefix);
 	if (!data)
 		return 0;
 
-- 
2.34.1

