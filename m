Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035214;
	b=XAPEduGeL146bjblTVvZ/phtZ0iA6YcaMOgvdRvA0iSUOQhWF4OdWW75rq+1V7R8Jodp
	 fxHEA1h5PbTKGIUshsm9mPD/1B1zpC+3ME0lEa57twIxT/fD0YOUrghLWakk7PUXJrrHB
	 xh/FDgQPbd17Dsjv9M3jkAAjHPYBudBfkXFVena1TG6o7wocyizzE9ea0dFnRKuEGmy+W
	 Lt2w0/wqJyRnax7HyoTtgWevD802JOGjnvLKp6hpPV8E+MWHJvwKPjDaitykMZSNbjXeK
	 ZPkOqxtU9F5nV0Qui26+omDpEr8dnaX8DWiw32XkTBfdshYY3GykoQp/0vnFcdzNwLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=H/x0U5cNNne/AHftcI9zsq6Saio5riI+/COqyK6h+z4=;
	b=s576LIvsSzUO1EqtftM1qp7UZVaKbqgy4ogvK7l3FQd15RzgBci5H1yeNn/kp39vZzKI
	 6gUyFDetzfDHX6hRLimHZ5RfP4c/EiMP6tW4p6kb594MmyFqxrtpm5TptY3Q5V96hnv3i
	 NSKkEe1KVmuFkQV1d0DryI75yeiiP/Kv+R0J5r7OmjUk5kHaJCjrq0/PqBC7MO0xlVkdT
	 K3SFSQ+P/0jjeM+QIPimwQDArH20/xInrm7VckH0RUpIPWgvVSTosRQGOIwXMiyQ+3nnl
	 InVuEe1pnrTFi/X8ox//cDTPFZXrRs5IymZC1nE90hs0ZZeD9y/3DNLSrwmYipk05Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yaK53jbA;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A7606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5A7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yaK53jbA
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8aea7b7ca0cso25872417b3.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1793035212; x=1793640012; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/x0U5cNNne/AHftcI9zsq6Saio5riI+/COqyK6h+z4=;
        b=yaK53jbA/omvpBImCvewhH0MekUBtNgyAbvPBPpzumNk0DkT7M3Qkk7qNiTLSNJ70y
         AEQbbwItp65AKmBZTv4Eii6pKb2VGhNt9EdoqqGD7N133unysYz1eaE3q4ocvY6Vkx2l
         rwp6Z23/rTZpUKBczIvVWyIlOToIOT/ozYUcrK0NR8PNXvEdJBD5c/6/oLD6Y75ARMFq
         sOtPUFZCUo+x0DKaDHLHzGwuhcMKBqAoCkkZWPsBHomVqEaisPBeATOtv689txHy5QJk
         t6QYVS40/FrpBfByciMIsSBevyHP3mb2NYCzswdu4Fw/zu0evknW8wJX2sl9KKfrz82+
         jZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035212; x=1793640012;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H/x0U5cNNne/AHftcI9zsq6Saio5riI+/COqyK6h+z4=;
        b=wGMWYrR9Nib6cPxzk5Bl0Dir1TpkF83UiQpf1IDxF+O8UNAwgyQibe+n31MWRr4SGX
         JOFkqPVD8LWYCj/XHLRCZjbZsDuxQB7gfCQ2X/E/iSQyO51941A928oFY13oMEbT3rKh
         X8gnp2bKcnzw5bk1hjdEse7ZkXyTJklX4qYbVPIzd1z/s/+vTSKYPRmht2AJ7W33dhxh
         Rg14zzioe9KZU0cZgzOcSRRf5idJOgq9KdhdaBheZ+jLnuAHaZg/1xjs1szkNcmKNc7K
         mF+kykxkixCXcKFckD4ywz3r07ti67b1zNdD48UYL8ADPwKm1WwB/MSwTTNzW0839Bdl
         S+0g==
X-Forwarded-Encrypted: i=1; AKwUvBzaDhgmnYdmzjHPpFoAUplG9pNK9QxwGV7kWS5cQwkDVSh/LSly90z/nMf+O5vTaPWdFdhrbyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjih6uNOjtyhS64XmkYrEPR4MMpQC+zQ0esUBFB1qjWHGY29o3
	z/F/Xru1ZWK6HtEHHSGsGT+5wBZIiByeCRVTAlWez6aWbcAUEol4uYkgM/VmJpkrCQw=
X-Gm-Gg: AYBFou2azBiYddzMS+fvP8oiWesSAzgir4La7478fA+rccQ431KHZu5SC0dpSNH1wAp
	jJoYkiqo7iG7dA7M1nRcV04/zLPZEW0+qsZgXIAfgMo2jJGcO979464aEGV4yiyU6VfhKgYjAgg
	htIM8fGepZJiGa17olg8ZT4/qk3CLNZBgTo3DlnGbIb4CR3vank/4V2ybtjVn4k7f0TQAVAPS2S
	Cx0449k/2O7VzwfYEdtPQWs1dd6bX7OXujIqSIrcxBgdN236ifMtUOtA+KqfnyCM7hSkDHi++Dh
	G4qOC7MDAvpEm54lVBY+iMQiI95qOOtgxnfDWkdpAkGBlN+iFoXkR7yvfLLoiGnwU/iezxb3tBm
	/PKCmtAc2UxdYZbRmG0C2pxRebIul2zuxMEGf5u7AMafPyppPrs4O9si/jm0oWErj9sAWcWjEPQ
	PwWUKi00EIcVZKmciWZpJNFmgfPpT7SA0T1mVof1LCBD9/5F6/L3GfOE5pyRoWD72Cn6CqznPnK
	68rcdCXbr09iTux9XlG2HDkW5if1cDcJ1PDdIc44DmuzST5+cfEcDgD7Zqreafg5VwXBWoOe45/
	1JtNQsUQO8lBTZxSCn23j0wAnOZ0/7clDCVyyAACoutYReCoHPekRZxv8vB4t2T8U+yJolsH0y1
	P2XqQ+gCfuA==
X-Received: by 2002:a05:690c:fc1:b0:8ae:a5b5:e97a with SMTP id 00721157ae682-8b166b64c8dmr52175017b3.13.1793035212116;
        Mon, 26 Oct 2026 10:20:12 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:5187:d81d:3a9e:a63b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e53e34sm35560387b3.29.2026.10.26.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:20:11 -0700 (PDT)
Message-ID: <e2ee251e8ad47c6f1e2faf9ed1be787eccf5215c.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 26 Oct 2026 10:20:09 -0700
In-Reply-To: <20261023173259.3275078-1-hengyul@cs.unc.edu>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu>
	 <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
	 <20261021153141.311425-1-hengyul@cs.unc.edu>
	 <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
	 <20261022120658.1328124-1-hengyul@cs.unc.edu>
	 <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
	 <20261023173259.3275078-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-23 at 13:32 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Thu, 2026-10-22 at 15:40 -0700, Viacheslav Dubeyko wrote:
> > (1) Check that deleted CNID is the previous to the next CNID. If it
> > is
> > not, then do nothing.
> > (2) Oppositely, we need to execute standard b-tree search in the
> > loop
> > by decrementing the CNID.
>=20
> I tried this loop in KVM on a804c5742bff. It fixes the first two
> cases
> from my last mail, but not the third one. There a (CNID 17) has no
> thread, so the search for 17 fails, next_id goes back to 17, and the
> next file c gets CNID 17 too. a and c then share one inode, and
> fsck.hfs -fn reports nothing:
>=20
> =C2=A0=C2=A0=C2=A0 echo AAA > a; rm b; echo CCC > c
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unpatched or loop=C2=A0=C2=A0=C2=A0 patch
> =C2=A0=C2=A0=C2=A0 CNIDs of a and c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17, 17=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 17, 18
> =C2=A0=C2=A0=C2=A0 cat a, cat c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 CCC, CCC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 AAA, CCC
>=20
> A search by CNID only finds threads, so it can show that a CNID is in
> use, but not that it is free. A file without a thread has its CNID
> only in its file record, which is keyed by parent and name. That is
> why the patch walks the leaf records when cnid - 1 is not found. Its
> first check, do nothing unless the deleted CNID is next_id - 1, is
> your step (1).
>=20
> > Potentially, we can consider to have a small bitmap of allocated
> > CNID
> > in every b-tree's node. Any other optimization ideas?
>=20
> A bitmap in the nodes would change the on-disk format.
>=20
> Deleting 8000 files (KASAN kernel):
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpatched=C2=A0=
=C2=A0 loop=C2=A0=C2=A0=C2=A0=C2=A0 patch
> =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13.1 s=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.40 s=C2=A0=C2=A0 0.44 s
> =C2=A0=C2=A0=C2=A0 odd ones, then even ones
> =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.6 s=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.26 s=C2=A0=C2=A0 9.3 s
>=20
> The patch is slow in the second case, because cnid - 1 is free on
> every delete there and each delete walks the catalog. One idea:
> next_id only has to stay above all CNIDs in use, and fsck.hfs accepts
> drNxtCNID up to 4096 above the largest CNID. So a delete could leave
> next_id alone when cnid - 1 is not found, and the walk could run once
> at unmount.
>=20
> Would you prefer that, or the walk on delete as in the patch?
>=20
>=20

I am not suggesting to change the on-disk format. All modifications
should be in-core metadata structures only. The algorithm only solution
will be inefficient and it can hide bugs, anyway. I am thinking about
adding to the struct hfs_bnode (b-tree node) a special field: u32
max_cnid. Every time when we need to add or delete the record in the
node, we need to update the max_cnid field. For the case of add record
operation, we simply need to check that current max_cnid is
smaller/bigger/equal than adding one and change or not change the field
accordingly. For the case of delete: (1) we need to check all records
in the b-tree node (where we delete the record) and to find the biggest
one CNID in the b-tree node after the delete operation; (2) pass all
leaf nodes and to find the biggest one CNID for the b-tree. What do you
think? Does it make sense for you?

If you believe that this approach will not work, please, explain your
vision of solution in details.

Thanks,
Slava.
