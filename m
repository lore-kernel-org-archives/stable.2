Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491563DFC61
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337507; cv=none; b=dJYjkTAAQ2aifHs/eMN+AJrNObkxpO5BnFboIvdP1wXOTPijBP+4Uf/cxx1CaBLaLnzjvLoqo0l8MjLBDObaLxoAWFcZEIzO4iQdFvIqPVhWatuJ4/yBNmJCXInK9e8CNUKY/yiG7Gn4h67H5KYGBgSqQwEpbGBxNww4UCGzMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337507; c=relaxed/simple;
	bh=RCZP6RNRIhcn7c6ICdIorZOEH3sijgDTepbEk8t5dKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiN1xYRW/LfkLSOUELbEnCFPL5gSd059VP8UU4dAg0E6KH+JQjqUe66NEfsXob7TRBfgtcx4c3Date1LexuyJn0tfGRCQJoeT7Li6JLWkAuLJK9D4Agrz7PRvQ9Nwvobq5MsruSg1M6nciWztw/XpR0H/59ktiukZo1PEwPlRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTHzh7vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTHzh7vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BB91F00A3D
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783337506;
	bh=RCZP6RNRIhcn7c6ICdIorZOEH3sijgDTepbEk8t5dKI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dTHzh7vflZFrkDob5shxnjB7Q5fH5AquAJVpqYDSQw4myoFmxIg5A1ocj/yXr5flJ
	 nOjzLGeOASaqZCPAC6Pxq/d17GFqtu61h/sJNnEb27ccWoGhc1PghL0mMgIt7T6lp6
	 LTxZv6dQ8ditH/8uypMSMepAomg9kLXMr0FLh7k1968L1xKrSazTgj1ziPSgdcwzzU
	 VOoRv1b+jVq908liC11AuB4bLSR6n3pclZI8mPU5m5mzaFKQQh2QLqkBzZRhoVGB4v
	 Jn8rzngrYmHIjtYIMZWLZNJvDhHMZcuXWz1y7g1Z+uVWA21QFR0P68a4IvaPvblgFj
	 TB9RbhCgRIj2g==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698aa8d4dafso2897352a12.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 04:31:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpx0ddH63uUv92pqJiwBcf6tRt3FFjcJJWNAJnP0E8rcAloa5aHIhipppqTE/pihwxdgCIb4zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdvUWEFhKlGCzG7A9CDE9l8KxDJxcMwt6P9BzPUIQrsaBMLAa
	wq4Av/N6yd8kJluUm3RMqV88aflpwlQLXaXJMwFJZMCWEQTR+pWts9r5/oWpGWpPCEnqJQGTNEp
	Wi5uh7VFXHr/76S1lwlwqz0/xdlBqLmg=
X-Received: by 2002:a17:907:9608:b0:c12:34ec:ad25 with SMTP id
 a640c23a62f3a-c15a69d18d5mr4163366b.65.1783337504852; Mon, 06 Jul 2026
 04:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
 <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <01B02B3C02CE4CD1+20260705111409.3834024-1-peiyang_he@smail.nju.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 6 Jul 2026 20:31:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd89HbdpoE3PAWHtmm9kqKuGGAdUWMVJtEgQs-cwy4n39w@mail.gmail.com>
X-Gm-Features: AVVi8CdqaDpoNmD9wo2ubOTy9q8KGscJdCVQ_uytQJDdNLuN4EkueIpNujE7oP8
Message-ID: <CAKYAXd89HbdpoE3PAWHtmm9kqKuGGAdUWMVJtEgQs-cwy4n39w@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix hole runlist memory leak in insert range
 error path
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 8:14=E2=80=AFPM Peiyang He <peiyang_he@smail.nju.edu=
.cn> wrote:
>
> ntfs_non_resident_attr_insert_range() allocates hole_rl before mapping th=
e
> whole runlist. If ntfs_attr_map_whole_runlist() fails, the error path dro=
ps
> ni->runlist.lock and returns without freeing hole_rl. This leaks memory
> of sizeof(*hole_rl) * 2 bytes.
>
> Fix this memory leak by freeing hole_rl before returning from
> that error path, matching the later error paths in the same function.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Applied it to #ntfs-next.
Thanks!
