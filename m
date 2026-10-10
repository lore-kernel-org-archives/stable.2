Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235752F12DA
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791675241; cv=none; b=ebkoF24srpebzpT3SIRZZph/ymZFF6YPQ3q+M+pQsPrjGttpT+cSBt6nD8GQrFcafuOR2Cno6ZGT7x/QrnyZnXshAYIMgjcaYR6rr02Git/NAY1vGdjw3jX8951qzPUjt/mf0743trQYOFDaDJjlIm5gmEH9RxdFHaa8+F+T2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791675241; c=relaxed/simple;
	bh=yfWzQB6qYGFnzcB63JH1GEVfFCx9VawYO44p1JaFqY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxbOT73fv4yxILUPTDj8nAuR8NCvRPjSq3rIsinVl1Xtoj20YbSo6A0OCagUW1a3+6NfEtXrFOu4FS4unegnkrdAfdbETMNTOczLznKrNP2vnZMNc/RfYLVzar0GpCF7kVv9T3k7yxiKA6OJHW3Ek28ugi3yS2iZt7p9bu+wbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=nCcL1IRK; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="nCcL1IRK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XUJnoizHqRjV2lEHRvMaIyHFuZqZCjH0FTOcKYJEFGU=; t=1791675240; x=1792539240; 
	b=nCcL1IRKN53eQWqwq3FKVUqZ9DltGNAfJOvpeGkVGLNqCmJ5zd2/jaKhThrxP+YQKS82aWpcU12
	2+R0+XGv/Bq28JES+wBzT2jrdcKL8xW/dSCWZ2vnrF9DXhR3Tnfc2zUIl/Op8oySk7X7d66cp8Z2E
	mO4NQwYOIB4et0H0eiiJPoeT0NZxKR+IGPfGEskYO53jYXVeNK1rs6kxPU4cVnk1bB8k4zJ1+jzM/
	lMfYc00a50xlzFCqxlSuDRaHi2sWkaiGpzEohrPBqfMAf0o56i3hMmZ8t+GikJD9iVuf8S7TMqnR4
	6UAyPRA5WZeRIQKbPoS6AOjLJ7fKM2HElvuQ==;
Received: from mail-dl1-f45.google.com ([74.125.82.45])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xFgZj-007q4v-0X
	for stable@vger.kernel.org;
	Sat, 10 Oct 2026 19:33:59 -0400
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so1725563c88.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 16:33:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxKCrG6UlRlBNENgR644bvMQDoW6xxbxdDAr0LGBJo4fgdWpE+oPlUju3NzbzHuMhZk4tLQbeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO9VOCkDr+RSMsWAvNwZ7vvoj+GfXP4w8cSCnqIu7Y1PMzQPEK
	9VNo+gVkhwI5r+1HaarsDw1V0Fe8Mwx2FZ1I0EtSDG3kxMTSeSLIMoX4jbP5hQhp4jCK3VlMCLH
	uSH7ZsDAOsAFH96Mw7bLDB5VaLejeQro=
X-Received: by 2002:a05:701b:241a:b0:164:475f:1a07 with SMTP id
 a92af1059eb24-16a55f1e60bmr7781779c88.1.1791675237998; Sat, 10 Oct 2026
 16:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009051857.758182-1-nickolai@csail.mit.edu> <20261010162558.62abcd2ec967b009d0cb3bbb@linux-foundation.org>
In-Reply-To: <20261010162558.62abcd2ec967b009d0cb3bbb@linux-foundation.org>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Sat, 10 Oct 2026 19:33:46 -0400
X-Gmail-Original-Message-ID: <CADGQE7G-PAiJ2W8uhFO_-e9GGtEPey=drfSqLfWdxXDys3mJNg@mail.gmail.com>
X-Gm-Features: AclHuK8NTVPdGlZpNuys5-JYOCzxE3B81f4B5GgR965MyMgqHe7NumhALMGGqqk
Message-ID: <CADGQE7G-PAiJ2W8uhFO_-e9GGtEPey=drfSqLfWdxXDys3mJNg@mail.gmail.com>
Subject: Re: [PATCH] lib/plist: fix plist_requeue() shortcut inserting the
 node at the list head
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	I Hsin Cheng <richard120310@gmail.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:26=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> I recently queued a fix for this problem from Alex:
>         https://lore.kernel.org/20260903222456.1881786-1-handyhandyman.ad=
am@gmail.com
>
> The two patches are rather different.  Please review Alex's change and
> and let us know of any alterations/improvements which you see.

This patch is equivalent; I don't see any reason to prefer my fix
(except for the test case that might be helpful in catching
regressions).

Thanks,

Nickolai.
