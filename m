Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A963D3CF6
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173993; cv=pass; b=hq3UTcVvp2QPalUgF8YTwKIcKL2zqdjqT7RSaPVv3PaGNHNkT8//I94QiyHrtlCTXFMFGiXKh2KFSvAXj43IzHASJZR+VoEgh8bLabXl3eLP+VAiWYtMZIJ0y3MEVV2AMXe+eEla+30wgngQmPwLVF/juQ/kaG74JullMcrqvAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173993; c=relaxed/simple;
	bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm/erMjwxYLzxWNZTosNYI9hA8ywjL5P5R8lHD69QfNwQKluTNaTqnVLNQn5oXAT8Q14Uf3kLw3Q+2yTAuPN8WEiE1EMqtpFKuw6dZSH2bAlg5N1OwwPXtBhCd4S1eiaXwCnvPffozdtpaTLQnT4QBlXeE72yzgpMiAX3ecgPg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+OL+TB3; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+OL+TB3"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363fe80fe8so11287818c88.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781173990; cv=none;
        d=google.com; s=arc-20240605;
        b=Vq6FtbA+HlKQ2znq9Vu5W5f0qV/Yw66kb7kXQAmwdlkPLOiLB6xjNhpfDrvQ4J/05p
         e0+mRQltpEX5VwmuqtvXxZyCm8lVK5MmMQT/Ovahw2vjp4ASazoNICJ93z+646cGGkDP
         XXvuEXrhP0XUExCkDsQp5azkoG32l3E/V5EL3dTjftNOOoFBN+38AR5OFmcAd+qNg0qk
         pTmQghNs3QHVaXienalB3gPIjqa6CEHBkhUSJ0/SCtIVyRsIfthXSiRvivg6DFgd7v2T
         7gw74ABWWTCisQ3pebn0JnXeEwRrjJeobFFb0tlJzWwFkvUAlim+8j1p1WUOs93OKj5r
         cMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
        fh=RhuvnqXGpU4HYcv30g33x2Dwql8sthywRk0EP4G3y4g=;
        b=hkiY+5srDfOiNj5Locou6JW6alu33XhVN7DM9LreurIt4VPvlB3R/UQRImts7qQMzK
         0LZNWVG3k8DcwtTPjqZ6qC33VYQgMQulP650NePEjbF4EigTmgC8JN7f+QRhE5EM0/Gc
         CDy2IlWM3c3wH/6pQxRCV1/PccaA0U/pH1eE7xSSQRDnZYri+fuVyw944cUForaq4Fb/
         URF0d2gTpHKkPnC9aIErn0CXwClyI4aSsKwFL1jxJwCDnmrshl+sjH4Ujvi7KCFw5Ci8
         wbfoDY3CTOqZUJ5R9oA5QmDv4HnwC3E3TPIWjnRzARZoRc+BihpyU1btDSUc59KAOGtw
         xe8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781173990; x=1781778790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
        b=Q+OL+TB37aF70BIKvlwIYDdzThXwwG259gKgL0jFQWMW2GI4vjQ6LCaO/SQP43twkt
         HIy5wCGseR0jsiumH5zcREnAMC+9CfIQctwIZgplJy9ALdJrokguuw7ZVXtXpwsz546q
         YAsA5nOxVun/bZpZ2BzWQB+rxotOZ9knUIfiRxAxijYuw5IppZ3Xe6c+Rt/QSgxF1v9x
         +gAASCYqeeLRxbdrRpvZpcZkCTLVdRSeTN25MXuTQmwqMkfQ0B/5hjBmQbk+4om5suMe
         zSd4cMXjAJ0Om2cQcsFB16HiCoj5RlomLACptSWMLazVEPmfik4wDQMe1V+rGt7AmBg2
         6IGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173990; x=1781778790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USjVFKaTOqKKMsfC4POylKAfJ6Z15YP2VbWw/lmqYa4=;
        b=MSfB3MOWhD+kKsrX9Rkacj9QWQqEzaXqX52jwEQCukjL2d9nf0jCE0DR2d26KOcffX
         ZRfTJzEkZ/bEsd6rNlDZV7lCv3AvoMN3ykLPRJVIUTAOJeMgLmJOAFJ2QnNYTtE7ibEW
         E+b4XemK8j6JbIpgiGnNVdvGHqz145ptaIU+NLVlZmdlVFTZgo03PeQW/45jsl7d29UF
         LetFp/dqGbfuJo6ppO+eyPC9slyLasxgtsvhArmNVr3bGltBRN8ZtSh0WCumo44wBuzl
         l+bOw3oe2n5u6naFjlFr87ORw+KYg5XSynT+NjVrefL7wm/jgtpoTWJK08D7FenKiikV
         XOIA==
X-Forwarded-Encrypted: i=1; AFNElJ9x53cz3CQrK4KJZHHmFmIc9Kk/Kew7O7ALUXELGR/BvHYxGr9jCV81FhK2LAvAx3ij3YnekMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpDy62UIq/f++/AACy+nkZUQGItNmvFeSNvpdAFwRzSI45xmU
	fM7JrxlBRJLswmDqVF90K9fORPzbpmFlbl5xMbLGbMd5qi7HceGZ6WatEJJUucOLCAIWH6Au996
	CQI6+ccsPFDRl9wEBpD5pybyrIHS2jjcC7Mx1mH6O
X-Gm-Gg: Acq92OGlcUcPHvjFgAZmGo4v21CPAGhSEUNJSnooEA/c5VyyUSIkDN0ff9Xpq+6ltEV
	QnRzY81U7dxGhg7e33pq7puoTL1Qo7FLfWTDeutiaeJH9QfsjghTUVtFIU+TQfMUw0QqYb7f4qr
	qGSvRKJ3Y7UCKFGoVz1aVBWDKz2Cl8iXUJvMjDe6xkalyU4YGWQBIWb0pqO8k/0jkzXBgbIzsZ1
	nXT4W+tYe9jqCkkrCN0bc7UTa+Icz2iW0aekz28ehVmcbUdGMSXrcOEBklW5oj8/Md73yTXVXcn
	mhtx9TkqUWWJTQZ7/oEeSiHxoyjtJ/JukB+/deUXU+iMrUc=
X-Received: by 2002:a05:701b:4183:10b0:138:177c:b971 with SMTP id
 a92af1059eb24-138423ed863mr961163c88.29.1781173989581; Thu, 11 Jun 2026
 03:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142351.2306664-1-elver@google.com> <CABBYNZKRHj0z6n9kJhOST53tpnbpS1wikgB-sjanZaYdXxNk+w@mail.gmail.com>
In-Reply-To: <CABBYNZKRHj0z6n9kJhOST53tpnbpS1wikgB-sjanZaYdXxNk+w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Jun 2026 12:32:32 +0200
X-Gm-Features: AVVi8CcTZiDNtSS2_ZUuIlLFtCgs20y0-fuTxWai6BS59EzQbJKMWEBzXUIsQuE
Message-ID: <CANpmjNMurZs1bh8_WEA-vbTjCR0UpogCEy_=4brU52OmAmd2JQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix UAF in channel timeout by
 holding conn ref
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 17:48, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
[..]
> While I consider this a much cleaner approach than any the previous,
> perhaps we could go one step further and stop using chan->conn as an
> indiciation that l2cap_chan_del has run/detach l2cap_chan and instead
> perhaps use a flag e.g. FLAG_DEL, that way we can make chan->conn be
> used for reference tracking alone and don't need to introduce yet
> another field for it.

I agree in theory, but this is a larger refactor and needs a careful
audit of every user of conn in conditionals. Haven't had time to look
at that yet.

Thanks,
-- Marco
