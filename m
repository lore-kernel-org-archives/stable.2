Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FE446BEA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139765; cv=pass; b=iNEwSgWUZkmLwZQJjccLDT0yKumfzdWSAcDxy36kCOcG3JxprHXJaVEp9xCQgm75j3EmmC7JEvKEi4+JopHWLPZzGkhpmSElF0+GZzp4oSYKUR2fcVUNM8JK9HC/l4bL1ATaaArwRs0T9/emoSwJVTQE+Z/qzC5TgheZg+VUyFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139765; c=relaxed/simple;
	bh=iBjTzwrM7uPF9FZnc+NZOGNgrhi8TWxMiaQDYcgwEWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6Bs704QGxXIypH4EIWA1Kot+nEQlfZXYM2iHfJC02zkAXYFwqKQs+kn+6jh0YWw0EZkNvpw2nM6DnyQfW5vM/pCq6eCgfp1aWiuSE+f9FXeMtZBzkcx6uSMkgnHTRgMcZ1iEiL2ppBhCWXlP0zAJPmwgMM4p5Iq/99zSuXWqZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N+LUga3d; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N+LUga3d"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5339381b46eso60630281cf.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792139761; cv=none;
        d=google.com; s=arc-20260327;
        b=koS032yt0tNr+HijxeyEJ2yG1Dy1Rbt7kWNHFk+pzPmP7H4vo91DFfnTZ3gn+du895
         VkW1yp144rvxxnaGHYBQ+mKB6SDhADFG9r/8PDaQ34wIcBuC3tYSGpb8Jj8/XIEHLI2h
         e4hDPcwhu4uHdeFd0aOdroIMvan2f1z1nHz4z5FI9WfYhLqm5JUEAXl2XGViYhrVs2qM
         x+uV1vHFPLd63MC5LzXya7t3kcper6VsdkVTdwFGZfjEuUGI40uwIQJw4hNI6X5pV2xy
         mG854i1Ui95rg7Vxj05JG97+D4MeWMK8kTA1w1jM/7ooV3mClSlQ1iuGo53P/UwDYA/E
         eP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iBjTzwrM7uPF9FZnc+NZOGNgrhi8TWxMiaQDYcgwEWo=;
        fh=5XtzQtaHB/xivPU9bDwSU68PvsOTAkg85gV06PUnus0=;
        b=pFQ1c0zx0WKDlQL4z5QpXnAVtXJpqL/y8dbL22KPDgaqYFaaHUzwyfyATzXB1bMmiE
         l6gdC4pqbM7ongPwvmRATe+r/KkNRU1I7FlJDAJ4ODdrMUG2nJeKe6se+VO+e7xhdnsS
         bWJ+XA1JLbn0c/ArHphhXDV+p1WJB3k3f0/5h29ZOjO9Eft8XAfOYo/vzQqGQL5rDC3D
         cMJusZ1XhQdItaeMGhuPuyKQ/L7wRvLUTfJChDfIyTFxxkcN+TjA8GIv+gIceMTKcLwR
         LsqEeig+Ku0Ix0x73ox6AEoQZFWjC+9OvVsghxx7tLnbWYDTb75zIWSZBPbN+Nhejqfs
         y1EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792139761; x=1792744561; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBjTzwrM7uPF9FZnc+NZOGNgrhi8TWxMiaQDYcgwEWo=;
        b=N+LUga3d9pS7C/594e24+3RT+9zL1b77jqfoddZGD5KtyGG0+UN+nhpzmLoVl2LkNK
         uy/6eoHHu7PXfQavkXhLyVV7xd36HkAhm5tJfWWtGxmNIMsJL/ZgB1CMNIK5FqsjNrlm
         BqQ4a6j0z1za/b1ZpfnAZ/OZnZZbbyDNm7G2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139761; x=1792744561;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iBjTzwrM7uPF9FZnc+NZOGNgrhi8TWxMiaQDYcgwEWo=;
        b=oUnDBjjqBfzpDW5ytgwFrs880rvX1EYdw4LPMKUtg9XRPOxAOV7l1y2Q1ZUl8eFAyG
         3bRf3uz+4OYVttb+wcJ0ADv0jCGok11Kszkszk1kKLU7CdaLoAGwB5qjZKzP3u5TSyWs
         YtwvJ7PgOSlG1JJp6mLuwmj69wFHcTLatGwgYxzKEnQcD9KeOkWoUG4Du+FpsubUVpja
         u+fYZlxzklKyrGd9EnuS5VAyr17V4tOmqQ0sKzPs9UZ37e2a7anbhEFu6711fwmxYXAm
         ZF0hMt5QoKrHY5cQvYykAhKnI2YDt7SjmbO9PybWcGNC2THopJ0610Biwpts0NuWRdiW
         BIYA==
X-Forwarded-Encrypted: i=1; AKwUvBz54H3Z2DfsR+tjFzd/kcuckmGuy9G9IEZQxlOAz/oAmw2m7PIxcGJQpq/m0t1DkUh7HEczAlY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqOWT7M9xQ08+0E64MSIKIl/3rvTEzaKL36ZvSMwh/AOkwIFmO
	7+NNmdM0yUqmGXwlWBmiZx9beMrFuIJxMdhLssrR8lVtzr58/mfbhXTLAUV77B83D11BRShbdib
	4zfWS361lDJXH/RcHkogxVjojrCJ18W4EI4dn1Swe5Q==
X-Gm-Gg: AYBFou3uEIO9HOgmQC2/T467hSBEZzV8hdEbVceFXqCynWJgt/jxuh8PdWZzjS+e/zD
	9SfVtakIEnNJy2gFHQam2Bg8AofyFofEl9UIyD2BSVRN/KvskvgdaohJQgVxSsZzmsS4n6T//k6
	bot/z3XTXEQNJMMaK2sMHkNqXsMol72e48seWP3RvWtP45PuIFHjRlX2cFfCkFIUzzN5hm+ScSb
	bMN9AAG7jM17YXrxnDoViSL3HfXuNO4uJ6Mdsy4nQKjCkmO/30bS51o8Fd3IcfUlJhKkopbBFDu
	mLzAPbuVo0OccGEd9F7TKnIyY7G6YGxoDg/ZUQ4XCm3ff9C6u0sQtGjimLYFvqoYxjlxNyLaT9c
	KPbKiy0w=
X-Received: by 2002:a05:622a:551a:b0:535:2283:20a3 with SMTP id
 d75a77b69052e-5359fb5bbf6mr346314891cf.33.1792139761050; Fri, 16 Oct 2026
 01:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006105136.3751196-1-joannelkoong@gmail.com>
In-Reply-To: <20261006105136.3751196-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 10:35:49 +0200
X-Gm-Features: AclHuK_aRBViiCONZv9-O9KLuEQP8UciiOW-lTnKLDrm2RecH1Ud-s3YQvmYjSc
Message-ID: <CAJfpegsa9dc0MmxpeQYY9-fam9fn8xgF4W7aCK4A_QbXkSGRrg@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: don't launder folios of a bad inode
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fuse-devel@lists.linux.dev, 
	syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 12:51, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> fuse_flush() and fuse_writepages() reject writing back dirty data for
> any inode that has been marked bad, but fuse_launder_folio() doesn't.

> Instead of trying to write back dirty data for the bad inode,
> fuse_launder_folio() should return -EIO.

Applied, thanks.

Miklos
