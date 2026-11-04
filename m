Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766538;
	b=awgAqPF0Ux9hRJYj0ApAIL32fNsCl7wj3BJyK0LeKFtzgeDhFWncGkLLG6WqSZS6IAKK
	 S52joSeaNT/EyM4YwC65j1NWNMFOmbRZKyGT5Q2zufb5ojxrtBkKG6rAcTWoZG3xJjzgR
	 HF0wgRTv8ptTgU0Wt/by3bUkooyVaP0hjOTM94RGOCsEBDQ/dJ04v0Mh+RYxNSn0019nA
	 qidEfRKaC1Jf1F3k+7zH8XKo21PYKwui/huEKKb9ag/SFVQJ2u+cSDQpvfqdB4Sae8eQR
	 NckXPwa03MrH+SURInlx50xhINydXZ3Ym706LkWXK7gIEftKvksvr4xGo2CcZNgfaOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YoT0N3seRwZx2djffCaiAALCN3DDAOTgxnkps9J0Des=;
	b=YQ3uEhlnlcNRVlHWuLzrG+kG3RObL/aFfT92WdAGGhQzhMkngAgAdx7bvfQAn5IrOFa/
	 hlMUoZpXP/y6Nft4zAMlMcvR+d0e9OS+6JG52r0tHzCq+p90wh9A/T2XhJYX4TBqRg0LP
	 Onzftl/KBBMLca8iCovX9sFkS9onmc2TTu8OLnTYVFREiPrj+nMpNMZPTWK2f0qhZUxGl
	 iwH237bLl3BGLqh/NK848OReNF1IZ3+PvrRygCtY7NE7QWQCWNwLFTq3C0svbHGA7u0Vs
	 oM9OuFvE/NjO2Y4eANs/w9gJfb8DZ93lvEL32PFNrvaVvoXyIAoZYdMeRg31G41dlqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dlxTkS6W;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D883606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 04:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D883606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=dlxTkS6W
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c3fd91337baso47569966b.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 20:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793766535; x=1794371335; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoT0N3seRwZx2djffCaiAALCN3DDAOTgxnkps9J0Des=;
        b=dlxTkS6WO0kkDMixr/T2OT5yCYhNLySmHefwmySTtvZ65QG2HNX1maV52KcQmjLxlX
         xzrtiU/ZCGE7ghRbCkTNT8yDJU2FUd3/5XP1UUrkCyo7B4emoEJvtbXostMivw99+ox7
         Al0yMDZGY4/zs3hPitb12/svpdGRWRjrqyKW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766535; x=1794371335;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YoT0N3seRwZx2djffCaiAALCN3DDAOTgxnkps9J0Des=;
        b=etWC1iFcpjJOuBGY2zdCZDCmBP5S1itNApkJmcMwsGEybqVtE4grdhClcIi4VDlztW
         1om7DiChhznt355Vud+ha3WdhmO3/W8nk458vjys4046nLkXbQVAtys9EoOkGs1CYl/v
         nT7IKdQw4VqRvWPlh/NwplJtG9kj42hkSt7SrCDoFPOZFPbL4cGjh3z79ykm4m1ZdpmT
         dpWXxO0l5L+mR5y9pvC+X5K3AXjhH2SK+MLy/1UcLaZUPgI4CGeYEN6a1hM9egH9a9iZ
         94W5f2A1kIE+XicW/JB3G7X4nRfEd3EalWRnLCgfg4mgUpEMO4+n6hTqjtzjVCaXmgWr
         Xsqw==
X-Forwarded-Encrypted: i=1; AKwUvBw6Fvn9sxrtN9NzIRtCmWwQzE8yYQpvuwMPMqBzX67rD2mFMDU5b1QzDl5w+9vM8vZGJF8q2VQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uWfXUrQBALjyB0lQzLUEqJ7Oi8ur5kw/mOzCYp87fYN+VAxrM
	xkgAycnPSpa72Wwhonmuo5KlpR/qrGXK8Eo2F9HtLIuSyXfoaH15mV2/PpZoLq271qJo8gnadfF
	6VuHOdfM=
X-Gm-Gg: AYBFou0tcwxM0jaukft6PQZK4NW3sh07/n3I5rguHHdJXamxn5sZk5da1AsR3IWaGgy
	U1a2Tm4Nq+f78HFTlLJ/JKCOpHD1/muzarJwa0pnSpHcyYCDT5ULVJMLFA0PgBTE6zW5q1ReUxZ
	BnWg2Rjoel9qgq9V60WShQw7Sye+TpFwDtRLOuTBsuW7FMkRC5tE+pXElhuPtZdVTImAAqzyF01
	/V+wNweYHQV13czNbQzDTwdx9KhT+LZZS/fa0U54rPhB39G948r85vhqETl7MkbD4AT+b2wz4jc
	IE/LdWyNzgrz8KOwQgJ5AG2UGjzqzgp+vDQoyFvOU6BvsKxVOUh6k9m6Za7P0TZHK7kagCymeoa
	matgq5Z8cmuiFfMnkxjrtoAXPiCOMAQvfwCjS3b/nJpMJIiREO9kXq6FiEt9/xVl8ZdZjrQrZ15
	qwyefooJcmhK4o5LlIm3/kkOlg8BKqOyr/GwRGE2bH1ZAizgSdymWvdvVuR+rkV9+OBhGALKLoA
	4omgx7LxDH+uukE2lJOc8VcK9jtGNIsfxq1DSvRJCOF8eK0Ec/3+v0Amz1aSSfWtDmmPYobwejq
	ICu4L0TelyiYVc+lcpnwa7xw6gLogQIBtmiB1T1G9kRUm9SxqBZ7auDHe38hRnJgS/wP7EFXVXn
	fIXI=
X-Received: by 2002:a17:907:12c6:b0:c4c:eb16:b567 with SMTP id a640c23a62f3a-c4ceb16b63bmr306608866b.19.1793766534694;
        Tue, 03 Nov 2026 20:28:54 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e46a465sm30279466b.58.2026.11.03.20.28.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 20:28:53 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3fd91337baso47566166b.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 20:28:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz20NAWyI9uM8IsW1poBKj27/YU41QPBV3eEstxYS2YBf/tEkT0cPquc0Pgas1aFfR7IZPZSdY=@vger.kernel.org
X-Received: by 2002:a17:907:3e8c:b0:c31:8984:7fad with SMTP id
 a640c23a62f3a-c4ca7a4bdd3mr1249450166b.15.1793766533308; Tue, 03 Nov 2026
 20:28:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154218.1668182-1-liam@infradead.org> <20261028154218.1668182-5-liam@infradead.org>
 <auKshDXKQXt1kvjy@gondor.apana.org.au> <auMbCuecFeRmBFSK@pc636>
 <jfvq7vkx73vzp2ukq6nwnb3v3g2ezdcyppba4oa5lpzmz6ls6t@akc46gonndgy>
 <urkgmijyytg3rrislm5fdzmfggqavzpiry23f6lpkqonvy2tqx@d56stj3eixfa>
 <auaFhOa5EBz4gJwK@gondor.apana.org.au> <xdzcyoou73blpfdlgy47i2ktrcsffnclerzojpgrxphid54gjc@nicdcvzqx447>
 <auqtTjXhD8is-y9f@gondor.apana.org.au>
In-Reply-To: <auqtTjXhD8is-y9f@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Nov 2026 20:28:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
X-Gm-Features: AclHuK8Q2xxyDr0nTOpQBX0hGVCNXuqdZQKlHZIGiyhVn_ThF61kvu3f6cKlY_8
Message-ID: <CAHk-=wiE0KG+jkhmJWifXuAVivtB63WCWtdEpGAex7-T0SHd2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Liam R. Howlett (Google)" <liam@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Uladzislau Rezki <urezki@gmail.com>, Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Graf <tgraf@suug.ch>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Chris Mason <mason@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 19:58, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> To recap, kvmalloc was modified in 2025 such that it can use vmalloc
> even when called with GFP_ATOMIC (commit c6307674ed82).  Unfortunately,
> it does so in a way where it has to wait for other CPUs to do certain
> work.  As a result, if you call kvmalloc with GFP_ATOMIC under an
> external lock, this easily leads to a dead-lock when other CPUs end
> up blocking on the same external lock.

Ok, so it sounds like that change was clearly complete garbage and needs fixing.

The only reason for GFP_ATOMIC is that you're in a context where you
can't block. That's the *point*. So if GFP_ATOMIC waits for something,
it's just fundamentally buggy.

Sadly, the commit you point to doesn't talk about *why* that
braindamage was done. Looking at the original thread it seems like it
was for kmsan.

I didn't actually find the kmsan use case, but I didn't search very
hard. I absolutely *DETEST* it when "debug infrastructure" causes
actual bugs and mis-designs. That's the opposite of debugging.

IOW, I guess we do have to split those allocation cases up, and we
damn well should remove GFP_ATOMIC support from vmalloc() again since
it's clearly buggered beyond belief.

              Linus
