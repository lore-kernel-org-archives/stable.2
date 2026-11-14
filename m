Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660649;
	b=sC6Hk2Wy63V5X1drRQjJG42pc759G3TpB8wbPicq71tO68h4wxsalWZ4v+Z0eR7r7nle
	 ovU4G5cn4tNx8r/ZUdIxV/qIPSqNb8xRxQZjBjv4du7idyeU5Of8++LmFZZsLG9P4ppxN
	 0BOBJnOin6aZZTm9GUjsJZSwgNZYoTQ6Ij6DvrEIJcra5drryYDS+bIUym/HunZGWL8mw
	 zqo74LuRaTEdMrBRmiGKRWZvtEPv6V91JQxFET+/0rdIkVUFNR/d2F6sLuB9DZb0U6hWH
	 VXPEIvYbGB7jpHAcBwkvlqulaYCkdHhXPOXLjNlZQF2namgE7QZORG27y6udNKskQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o9lRP47IkEw2gtLAxsTbTVug9BfkbG9biamE/Xj5Vak=;
	b=Fvxvokxnexl8tnkpUymqx/ps6A5LrigfAorWvfFMzsVf0o6QoKcScW183QpWUns+7Bsa
	 wA7tltKRqv0MoFg+QgB0xNc9eyslEpf2zF4dP6913lOobMVKNa2E/GwXw6/LW2o+i5IJB
	 k3QLeH7m1kQDC/tX0fnsR8fa4Vd3Vw2WIQ2wULYGkBrrwg8cYcHS9cQ11x/49mS6zZ/Os
	 ggkPztOz/nAfPMfP6ZcuMN4trO50lOo7/+yn6bFo3dL/a3CF0p/urxPAQGun+t/q3jpUG
	 KG+hIoJGvuIzRKEhnN4yr38F302rbI7QwiW0CdiQg31ivVvGc+HZlBRN9FGByp6SMzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=PcyrPwRh;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F51606A339
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F51606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=PcyrPwRh
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-94959217274so257103385a.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794660648; x=1795265448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9lRP47IkEw2gtLAxsTbTVug9BfkbG9biamE/Xj5Vak=;
        b=PcyrPwRhBCE0C49+FKIAJCqWGzVmXVaIf8WH8EaDPApUzHQ3gb48lOUKAGQ35VjRDL
         Ow3ery7URY/OzZUMO/j54T4a0hj6C5cUoHV0JnsP9Xm+1+Ku2ZUlvXeDY6LZdaPpo3NB
         dk+79KGip03kDOZVoB8sSwcqlRM6H2bjS88jamgwlYGhqeX8zlMAgx9CXSoGhb0UT6hV
         U5SjPPXAhN1QL+E9yYOOY41duypqLwb4dAxUjYcsEUneyD/nCn4wEskpbiQ7egE+blzk
         NX6tbPRitfdu0KsddzP+Zn1qXlvCL8VSQKNytjMg1gwJTZOovM9uKQFrvs92N3br3u2g
         nopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660648; x=1795265448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9lRP47IkEw2gtLAxsTbTVug9BfkbG9biamE/Xj5Vak=;
        b=EvZiDUCaJg9jbm8nSkKSjhju/dJo2YMoKESyN4XMjWh2d9pt28r/v/1iN2S7AuxZ8X
         4A8U0K48wejoYGutMtegq0cjIxOTz5zc53R+nzA08IupI6mrymXiPobbnyYYpS848WsI
         RJ82IyQsz0F0WhhTM72gPS/6zWGVEddCouV0fWet7/Y9mHMGyR/S12pGkuBRStnFQoBu
         DkTc9/8aKJ+smkSLGp3FcFXLHQz42F6lJKfd+C1QHTxIbIvJTsUPG2wfZDXwuWUkpWvk
         fgtfhkaK0qx0EZUAbnWrVQ8VucFC1JrSISvs5sJOxXabNtcPTln1n+58QqlQ/88z7iV+
         f9pw==
X-Forwarded-Encrypted: i=1; AL+hErFSuqSdQRHgfjfU4n48aZsOw27ImvUtIc6Ujh67SyUHIo5Eko0MUkNwTpfssBLub/ndFKD6RfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RGCoMjFyWqO3x2XYgcQjUv0v1ZAe4JoEa87J3e5kRxV/69WtN
	tLRj+9FJ6rE6Tvb3lDU+KrDbe6cQeAP+xsekpEHvVXeFig+oiA8yTi7PhGtYSPFqYKVeOLhhVdp
	H7WNVxw==
X-Gm-Gg: AYBFou0TxnMxDFlAQALdn6+7OHdzO1H3Ija31KkysEeGNF6a6bP8M86KTvMvpAmbGEV
	DnzDnpNdr9B3nXnX7yILUq+ehNYAY9cqpLaXBM6piIemvwc6SeTgGk3W/GENphTLyno0cLVcbPN
	lH03A8ankZxxTMiZM0tXelx9SnEpxqXCds3J7UVX9TgAWvMdBVv5lbQLXd7Rlf86KM9HPBycTEb
	ifbx6+Omv8c5fkkhJD7RvfzXOumsDKToCBhgCeZKDSns0d17VuauCCT0kluM5eq1oRP1sMLV8gW
	wn7J6UQjoV6x6fAk4YsqXAxEHutTQNobRgr72XtIaHQ3sA++0u94W4NtoZwipIxuZER1h2wxyvS
	jGVysoN8kd1Zy6nKBmmQK+Sm/kTsNZpcLrB+Gb45dR2l2hxcW5I1qfkIfI0n4KHUMWtexDGFNDR
	deSh0SQMapqu0dPFpw0bjTOqfAQE7LmhQkt85rOMs4X1LxBc6g28coh3EPdxM4YMDIU8Qxoap4J
	M19rnQeeqzX7vOiTY0vtZanbsMBHnLZ1Lnf33ts5kOiNP3B3z9N6a0y0W+rxlpzHToJxIyL1CNy
	sljm6nE7E0l2yFIKbcaLSIsXSjuK4gsazcjNyholRDdroYyQxIY=
X-Received: by 2002:a05:620a:1b90:b0:93e:bcbf:4ad with SMTP id af79cd13be357-9494bbbdf65mr776663285a.33.1794660648250;
        Sat, 14 Nov 2026 04:50:48 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c5fd154sm397598885a.2.2026.11.14.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:50:47 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] hfsplus: do not end readdir at i_size after an unlink
Date: Sat, 14 Nov 2026 07:50:45 -0500
Message-ID: <20261114125045.466604-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0205ef88738917a6d307b4e334e2dd1b0851317b.camel@dubeyko.com>
References: <0205ef88738917a6d307b4e334e2dd1b0851317b.camel@dubeyko.com>
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

On Thu, 2026-11-12 at 12:44 -0800, Viacheslav Dubeyko wrote:
> Frankly speaking, I don't quite follow what is the issue of the fix. Do
> you mean that we create and delete folder in one thread and execute the
> readdir in another one? Or do you mean that application has several
> threads and one thread do readdir but another one delete file by file?
> How this deletion is executed? I mean which files are deleted?

Sorry, the commit message was too short. There is only one thread. It
reads a part of the directory with getdents64(), deletes the files that
this call returned, and then calls getdents64() again on the same fd.
This is what "rm -r" of BusyBox does.

> Even if we delete files in folder then i_size is dropping gradually. If
> we traversing the folder's content and ctx->pos >= inode->i_size, then
> it sounds that we already showed the existing content. Do you mean that
> if we deleted the range that we already processed, then we miss the
> rest of undeleted items?

Yes, exactly. ctx->pos counts the entries returned since the start, and
i_size is the number of entries that exist now (valence + 2). When the
entries that were already returned are deleted, ctx->pos stays and
i_size drops, so ctx->pos can reach i_size while entries are still
unread.

A small example is a directory with 4 files and a buffer that takes 4
entries:

  getdents64() returns ".", "..", f1, f2   ctx->pos = 4, i_size = 6
                                           rd->pos = 4, rd->key = f3
  unlink(f1)                               i_size = 5
  unlink(f2)                               i_size = 4
  getdents64() returns 0                   f_pos (4) >= i_size (4)

f3 and f4 were never returned. Before commit 4b0496432844,
hfsplus_delete_cat() moved f_pos back for every deleted entry before
the saved key, so the second call started with f_pos = 2 and returned
f3 and f4.

With 1500 files and a 32768 byte buffer, the first call returns 1022
files. After they are deleted, i_size is 480 and f_pos is 1024, so the
second call returns 0 and 478 files are left.

> > +	bool resume = rd && rd->pos == file->f_pos;
>
> Is it possible that rd is NULL here?

Yes. file->private_data is allocated at the end of the first
hfsplus_readdir() call that stops in the middle of the directory, so it
is NULL before that. The current code has the same check
("if (rd && rd->pos == ctx->pos)").

> I don't really follow how the resume variable can help at all.
> Probably, I am missing the case. Could you please explain the issue at
> first?

resume tells apart the two ways the function finds the next record:
from the key that the previous call saved (rd->key), or by counting
records from the start of the directory with ctx->pos. It is the
condition the current code already uses to choose between them, only
computed at the start of the function.

When the call continues from the saved key, ctx->pos no longer says
where the walk is in the directory, because entries returned by
earlier calls may have been deleted. So comparing it with i_size
cannot tell if the directory has ended. The patch skips the three
i_size checks for such a call, and ends the walk when the next record
belongs to another parent or the catalog has no more records.

A call that finds its position with ctx->pos (the first call, or a
call after lseek()) keeps the i_size checks and the "walked past end
of dir" error as they are.

> I really dislike the comment in the variable declaration section.

I will move it out of the declarations in v2.

The HFS patch (1/2) is the same case.

Thanks,
Hengyu
