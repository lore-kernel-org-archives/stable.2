Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256374;
	b=hhbvtbTqs0nwC74bstW3u2FRN8KCd4mMyzjyDe2zI2o3zsTx0N44Jr9KyG2rn1YzRUrw
	 WfvCU1XE5gJ3TE7x1fGQBaJjiyGOeLeK6PY8QqPW/r90H+P9vI4cfevYpS7VdOeSKbhNE
	 u9X8rwXgdV82FA4VFHouRtDwb5X21AS32z/jKKpBxWPD2HyHPM42Rnr23BRIFsDBNqoEK
	 6azryVSKGnAyAo5UWMnH8UR7jcg5npzq4UlxsJ1xoTdwFv/uM8nb3LMR6zou+EAYmr22e
	 1pjK4HKdCDNCHfVSJZWAQ/mz4mmyyFQi9ksdEPz52SPzughK4YrLKkN3WGGszi9Zk7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hJhDA0HHOsjziAeZM3NsciPPcqDK7FCM8oI+pxwYpdQ=;
	b=LJn2PSQqa941mNcaTGcEwr4ixiXbD0QdAUQrbPFDXhNV4nhURnVL2GCMSpXGA/MzQupA
	 UXbIWx+QTaiWvJirTFpHBngVIhoeCZ+1QSc3MqzRugWuLvzkc8dAoEiKeW7JAmZciMEZT
	 pls5PVp2jZvZwKnAsvgY/xqPQ3L4Rl2e3cgFFPsa+zzZYVR/eRjTC/Xvh3Vb637imNAlK
	 AUwrJ58PWVVL0GPGZ+f7A6EZ+5PJkBu9bY7UdB9kTdo0LZie+u7X482d5mbEMB4KEPW1q
	 tpjchfHemTlhZkJmFAIzDb8mlfk1Cb7DTMBHclpCRWtt24YOoHL/ZKB3y4JkPt9jZ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Xf+nF9uc;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3D606A331
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A3D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Xf+nF9uc
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5361e313e63so23270371cf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795256373; x=1795861173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hJhDA0HHOsjziAeZM3NsciPPcqDK7FCM8oI+pxwYpdQ=;
        b=Xf+nF9ucdTTjnG9oVmLa+B8u8rpT8wdbviamPGNjTprLBdVOnPF5UZbNJQUYypM+5I
         A22nUmpg35PPerUqy0cwAmtSQCX7oDmzyFdXRXNWU/GmIApS3oJKO/ldov2xL0rXkiD/
         vX+Rgzu+5Pi9YQbgalz6e308OthWdyTHJe2WTAdts6eAiJRWLGtiQDVLeeOhR7SmEQ4l
         p21ab3IDQNB5E/b4hkNW92FCZBn1gvt+lesGu5VPe7VtgpSwtCsibL1Rw8UwNgoOFmcy
         jn/L3hueCIsNnBjLGFim7E7R8yqHTJcCfzIEdvyewwgW2DRvBPWbsYBgvhX8dJUN7YUM
         cP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256373; x=1795861173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJhDA0HHOsjziAeZM3NsciPPcqDK7FCM8oI+pxwYpdQ=;
        b=sJa7ToB2YkCq+2En5shFRnPg6KSSiiPQmU8hcHwP/MOgz6ePm1gSVhCpc2vj91Hc/w
         o5KcIX0N74Pi45Ow7uX/bfBILrtf3Xaabq/kKY5Qz3J1GzfTG/bHXo+qK/IsArF2GbjN
         djhlG8DDu4Wo7IKLC644OQSTtZ/5av3A5AHCHTcvjWeXzAxkKeBMxKy55eOANl7vbZSj
         fswA8uA8uAKzfjGwqNxrrvNCqBpeuFmy+IntvQ2/yKfX8T4ojROA8c/MgiygX6uufTAM
         nKvizZcKij9d1p8aB5ybaR9eSayxHGmXqoS2Zdh3LFrZ/fReOcKqmrID4I2ED07Jst6u
         V7Bw==
X-Forwarded-Encrypted: i=1; AL+hErGm8HcmY0UQqeM6wO2y2L94QnT+yOhpQLTs2BXc9ZRhjjUSUAZjjAyeML/n5xAPEM+n54KpjbE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cPCgv1X6i24n9jbJaQ7nMJrCR/iQENFehbTtKiBeIla6TLivq
	KDWkX3+sP0YkF0mFO3Aqsy17hSJBprDJ4475UXtUBQJit0nqspHMq221wkMbbmThdA==
X-Gm-Gg: AZFdTZeAHCerksIoBplO7qz/QdGK+0OPeFG0FiqUfYR4lKeLYZzyhrl9RtrpyhiPlu3
	0zneDLNj4qCtiokEjrUuxOPFwWmSH154SWgzfGFgO+bbB1sWKUEHwqsJa7rc7spT9l5AWNnlG4x
	NsR87Tx/eBxBNIUXGNx8xIMpwqU1H01kcQ+0ie8VzebfWY0pQvI0OA8NwzhO7h3awnwwSHnu2b2
	WxSF8zhdjLZAi7pGDcN4BAmepv7S5QRQWlvQiRIvZZnnV1gF7JxES6IGVb7GG0LQ0gvjmFeV5x5
	v4GNOeGX4ppiaEH/gAP9xT6h+y2oWIil399GXXrgbypkKN72QuvlfGey3/7Bw6mi/6X7SW8dYLw
	KUrpltNCSSrb+cHm8ZO4phSq1zjhrvKMtnsowJFVm6MRsoJulBQxs1WLn5NqX2UWS9sDYaJamD/
	ITT+gBXnwQkkYVrMM6xUwbVNERNBjnyO2NRZwYBS+Xd2yie9jRO75Oz3PnnXDGt4o+z+T+GjfBP
	bsCfEEAdhaYKQyhf8w83PjUikJME9GfPx1icieHTFt62VoJvquQJGS6siUGPgzXljDj2AKnCiS9
	eytGxyzg3qQm38gtcwP+XfRGQxpmD1QNVyV3DjypkWo/ClbVHvCs
X-Received: by 2002:ac8:5d89:0:b0:55d:3201:3083 with SMTP id d75a77b69052e-55d769e0ce2mr103684981cf.26.1795256373055;
        Sat, 21 Nov 2026 02:19:33 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884c35dsm45433191cf.16.2026.11.21.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:19:32 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
Date: Sat, 21 Nov 2026 05:19:29 -0500
Message-ID: <20261121101929.3395994-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aad484f0a78493723cfe379df5916e9f7f2a2bb4.camel@dubeyko.com>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu> <138ca05e57377469c0e44126314c98d008629229.camel@dubeyko.com> <aad484f0a78493723cfe379df5916e9f7f2a2bb4.camel@dubeyko.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Thanks for the review. OK to all remarks about empty lines. The other
points are below; there is one I would like to check with you before
v3 (the flag).

On Mon, 2026-11-16 at 17:02 -0800, Viacheslav Dubeyko wrote:
> > +static u32 hfs_brec_cnid(struct hfs_bnode *node, u32 off)
[...]
> This function is completely not clear. You try to read the
> hfs_cat_rec. Simply read it and analyze the record. Now it looks like a
> dark magic.

OK.

> Is this insert argument used anywhere?

Yes, in the loop below: an added CNID can only raise the maximum, a
removed one can only lower it.

> > +	if (tree->cnid != HFS_CAT_CNID || node->type != HFS_NODE_LEAF)
>
> I would like to see some inline function with good name for this
> check.

OK.

> > +	if (!cnid)
>
> The #0 is reserved CNID. It's not good choice for such check.

OK.

> I assume that we limited by tree's height here. Could we used it
> instead of infinite loop?

OK.

> I dislike insert like a boolean value. Why do we need to inform this
> function about insert? Why this function cannot make this decision
> alone?

OK. In v3 it will run after the record is added or removed, recompute
the leaf's maximum, and compare it with the old value, so it no longer
needs to know whether a record was added or removed.

> You don't need in done if you are limited by b-tree height.

OK. The loop will still stop early when a node does not change, because
then the nodes above it do not change either.

On Tue, 2026-11-17 at 16:20 -0800, Viacheslav Dubeyko wrote:
> > + * of an index node. If a child has no max_cnid yet, return the number of
> > + * that child in @child instead.
>
> Do you mean that we return CNID? I don't quite follow. We always have
> any CNID in the node that will be maximum one for node. How is it
> possible "If a child has no max_cnid yet, return the number of that
> child in @child instead."?

No, @child is a node number, not a CNID, and this only happens for
index nodes. An index record holds a key and the child's node number,
but no file or folder CNID, so an index node's max_cnid is the largest
max_cnid among its children. If a child has no cached max_cnid yet
(for example, it has just been read from disk), the function returns that
child's node number; hfs_btree_max_cnid() computes the child first and
then comes back to the parent. I will make the name and the comment
clearer.

> If it is the index node, then we don't need to traverse the items. No?

We do need to: each record in an index node points to a child node,
so the loop goes over those records to find the largest max_cnid among
the children.

> It looks like internal error but not I/O error.

OK, I will return -EFSCORRUPTED.

> The max CNID cannot be lower that HFS_FIRSTUSER_CNID.
[...]
> I still don't see a necessity in HFS_BNODE_MAX_CNID flag.

These two are related, so let me answer them together.

max_cnid is not stored on disk, so a node that hfs_bnode_find() has
just read has no max_cnid yet. For a leaf it could be computed right
away, but
an index node needs all nodes below it, so computing it at read time
would read the whole catalog. That is why the code needs a "not
computed yet" state.

I can drop the flag and use max_cnid == 0 to mean "not computed yet",
by starting the computation of each maximum from HFS_FIRSTUSER_CNID - 1
(15) instead of 0, so a computed value is never 0. It has to be 15, not
HFS_FIRSTUSER_CNID: a node without user files or folders (only the root
folder, CNID 2, or only thread records) then gets 15, and on a volume
without user files the root gets 15, so next_id stays 16 (15 + 1).
Starting from 16 would give 17 there. Would this work for you?

> We need to have comments at one place for the whole structure. Here it
> looks not good at all.

OK.

> I still don't see the point why should we change anything here?

Changing `<` to `!=` does not change the result:
hfs_set_next_unused_CNID() updates next_id with cmpxchg only if
next_id is still cnid + 1. The `!=` check only skips computing the
maximum when cnid + 1 > next_id, where nothing would be updated
anyway. I will drop this change.

> The max_cnid or max_cnid + 1?

max_cnid. hfs_set_next_unused_CNID() adds 1 itself (and uses
HFS_FIRSTUSER_CNID for anything lower), as the old code expected.

Thanks,
Hengyu
