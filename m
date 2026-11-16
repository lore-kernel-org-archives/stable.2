Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799920;
	b=5tAqwUqPFc9kn+98916lSuzbTbyp+1etfCOOxyXyPAovL0UfIg4nar+WnsWXrCZzyDBn
	 uxN37Uij086aAXeCOzcFwqLXoevtIxoHpCSZBQKW5+XHmICthzRqaM6kzI6nhW8dMxoTs
	 GU3q427CiJQ1maKERdDuUh2vAuUOYRNSOiGgAzp0ckbqnVbCRp3s2Ot8xsA++rjHFudtj
	 t08EA3k4ef4tE5dfk32AZBERI2zPGEjTnpYJzVDw7M7jYaDf+M7QeABiXhuVBtSGiM/AI
	 uziHvaztnd4yUOXs8kr2hyfy7lpfsNOZ0+OKfHSucLHd41bf9xoRPf4G1tSNet4tFbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=QbnteX2l0Jb6TmLxEnzbnWrqpp3+eF3+v/z+RV2T9cc=;
	b=ymS1v5u0YIDCDzDopCSevQv7+COjkkUeOhas+sMzTyHNB5+btEqazLCkXVd6/jzOl3UW
	 vaWXUbWVrfcQjNCAARh+mDtjUhN7eqVGOgCfGNypJhCxy2CImIZCUg8i6W4oae57GykYK
	 RLJUrHN/JYa/SSDz8z0m1f89QRVjsvzhBrnvL8ZFROiGnMEx4VLy85pHHMiN58J5b816P
	 RcIy8hUQCn7YNib5gQfIY6EVpTQ04wUC+QAvBdDvmzDOhL/5IjhUZylsAACTg2Kc/mR6+
	 Kd2Rlm2CR268ieJU8EbLXDpTkk0zD3iOo5J7kKrKmzdw2mwqrzg03gbTsHDJ5mlqJ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ERc/RIxY";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2082606A31F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2082606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERc/RIxY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37600b0db49so3550620eec.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 19:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799919; x=1795404719; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QbnteX2l0Jb6TmLxEnzbnWrqpp3+eF3+v/z+RV2T9cc=;
        b=ERc/RIxY2S+iijnFuJRf7WxuUXnbOU13f1iLkWLamCJZMLTwSUsYa1XGt4TxAqhiGm
         NGjmzYjQVJLxAClTkWEGcXp132ZnnsraZKxuptxOXMIfkATkIhGz4o7ZVWx9aYQTEc+o
         Gezuh6l5bESkTv83LfXLlx8RS7NyJnvuhhRoCb8us47fZtRO1hS0O1XVK6Qfr0pfk9iq
         LP+NpvWIYGEnCbykbaoL5wruuUUYAvhNjZlDdKR9sRQKiizVd3cPh876Zn5OAIdT6DH1
         QqWY4dt64XKpQ7EBmx5cYePHVIRlgLD/dRT+fLRnjSYl8cv6SzYmiaE0j8/Wp3nbtdlf
         rK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799919; x=1795404719;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QbnteX2l0Jb6TmLxEnzbnWrqpp3+eF3+v/z+RV2T9cc=;
        b=ZCgSm1XngVjJ/F+1FMswZaMJwvMTdhzO0RFE+FKcBqnoBvGQ3ZT89ZTPjmAYYuUv3x
         T65Uom6X+ez7QitIcDFHSPzSEoAs0PjkBh9sdHdU1wfkQliuezY+wiLo7fxfeT6yfEwU
         r5HKtMpeOKsZft3CF2Zy/3KDkg6CvEKL9TLiMKw5EQcZPxLvOrbbj2a35e9oMSxAu/m4
         6LEfdUw2c2azLSvdxJTgSJiSWbMcrklLDCJc7SokDMzqZI2Tz8wi+s50DMOYHlaNflMe
         yChs5XwDVCmwRYtuCNXnEtm4tqD9dX7KABdmZN1Szq8AnJZo4Z/tCMfyTP9aDBQNuOeq
         hzHg==
X-Forwarded-Encrypted: i=1; AL+hErH0PwLXq6xOjhhd3HFX89wuG7u1/RuUXuFdbnQTqCiH6VHUd+vmuR7I4w7N6Ynrv3aAcSkMssc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2GikjSqRWUibhuzCHjFzw5Pl4o1xVOD2aAbeX5Se+nR5UP/Nt
	j/w+vjTs4cScZKI4EaGO1S6bwQgfPMQWAwHMtHHky45A4V+i4zX3wPA7
X-Gm-Gg: AYBFou3NRjkV8NQ1nEYn4ZeDnXAeIHB9ni2MFPtj1bfEkTnMaw5jdNyKWS8Q/pFsLL6
	/LUvzKm3OjjzH+icR5pPrIOE/g8Ij46l/9RB1znIh2YWch5naaP94lnyMNqkRKRyv2f4XivFmD5
	jcwDD7c8bJQq5EWBGy62QVid3t1PZRVljRD1WIsv06KNM9QaaNgdrvabrdSNtXITxihKxBhb+bt
	vgGadq3+SlW5hWFh0QTVXwnU+UNlMHc0U1+cCBjyqfeQa9w09s2SfB28VrylPd5xr6+y52FxC87
	vKFMkI3VZ71vfMaCktYqwxj+8SFVeJ5In+mhkZNQORYtHFjtdoeGYtSzDxpnas/YnvYDZlT0Xcz
	JUnMvfG1cIGhASWwIazffIxPErjrug/4OVayq38kU6qK+GZHRCo4SduUshl6bzVX+IIJxVPw/Hf
	zzeodWEuR5CrQgurqGmXpCJyze5M1/VQrae3O6OJN73sa3ljsAJzKLqnTPVovzy20JBl7OXxbTT
	w6m/1G7P6ZL9tUoh/1GMbRlct19Aw+13RrvkLiGt1zJkPweRcuMoJEsLQqFAUEletYtV09gTu+2
	B4ixYoHudG9jPefTu+I/qm3pxIgUleJZ5iUINgc/Gfd8cdJB
X-Received: by 2002:a05:701b:4294:10b0:1b3:b3d5:566f with SMTP id a92af1059eb24-1b5030990dbmr8883780c88.11.1794799918907;
        Sun, 15 Nov 2026 19:31:58 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319e381sm27456340c88.12.2026.11.15.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:31:58 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] powerpc/xmon: Avoid unsequenced accesses to tsk in show_task()
In-Reply-To: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
Date: Mon, 16 Nov 2026 08:54:13 +0530
Message-ID: <1p8l8nmq.ritesh.list@gmail.com>
References: <20261115-xmon-wunsequenced-v1-1-42ae3fe45bf4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Nathan Chancellor <nathan@kernel.org> writes:

> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in show_task(), which can
> break the build with CONFIG_PPC_WERROR=y / CONFIG_WERROR=y / W=e:
>
>   arch/powerpc/xmon/xmon.c:3262:3: error: unsequenced accesses to volatile qualified 'tsk' [-Werror,-Wunsequenced]
>    3261 |         printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
>         |                                                         ~~~
>    3262 |                 tsk->thread.ksp, tsk->thread.regs,
>         |                 ^
>
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
>
> tsk was made volatile in commit a2305e3de819 ("powerpc: mark local
> variables around longjmp as volatile") to ensure its value in
> show_tasks() was properly restored after returning from a potential
> longjmp(). Aside from that, the value is not being modified through
> other means, so rename the volatile parameter and add a local variable
> named tsk to hold its value throughout show_task(), clearing up the
> warning.

Yes. Reading vol_tsk into tsk (local variable) in show_task() function,
doesn't cause any functional change and also fixes the unsequenced
volatile accesses as you described.

>
> Cc: stable@vger.kernel.org
> Fixes: a2305e3de819 ("powerpc: mark local variables around longjmp as volatile")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2199
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/powerpc/xmon/xmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

So, LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

