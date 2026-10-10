Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E111415F20
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616177; cv=none; b=WcGrUuoalPkZjSz2/a5lu/EM/5ieTByB2eQAe3tiG2V8h1XnpDjadsLLgMRzOujCDidQA0uXcIDcn0NoXIg/7wkc/Pu5mQAzqlzWhdoD2/cMJzCaPdDOqlnbtExaOjJrqNP6c+iXMwFc+j2GUI5YXr71oh1dw4yi9P25Lnb24qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616177; c=relaxed/simple;
	bh=S9G+sBSYSmMXBhisqHbLvHHceupQGvHLcCB8+wA13sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8A6Ye0bV9UaYo/KUpZ8X2sGPtZ9ZsRuki+5Zs0XMrFVsFU985YGlhra27ZoA57rfkIM0KX6de7xoTQnQWouMyWhSz0taH5EmwkrgHsf2ahluUfVr/v9az6VY4hTax2bumozf/HVQBHFBWNFxzNXW2oIFmsTcWOsqsCk2Qc76qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akDJGZaj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akDJGZaj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4956869750eso3530115e9.2
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791616174; x=1792220974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMxjq59OBAtUnM2DtD0UmWpPdwh4PH6N1GUz99zOIpQ=;
        b=akDJGZajRpSHge1h3pbSp7fcMkXJ4IJq4xlVRPHc4O07SD00Hz9+QJ+CLbtQpQv1VD
         bAyVJ51mwdfNykZzqRKYIW1RVHmhbVNnf89CB8hB2mmSVQ21QFQzFk5II9UW36zoFYNq
         UGNl0wjuC2jAIPS9Me1/MJwwQU8NFP3eY77M6gDqB36gZ0rjoSNReSExyuzlMvKwPnjm
         Ide8N/B0jBzs+c6uZW+NKDtehjIZ7H4fvs/SV7xz4A4fDmtiFdAILgmRPX/8rHsrQ3B6
         V6AEgcaON7gs5l+71xZ5FFYDC8iFtwO6gKTSs7YTACk+aINE+I9YIAUDNnky4VrW+LwP
         1lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791616174; x=1792220974;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMxjq59OBAtUnM2DtD0UmWpPdwh4PH6N1GUz99zOIpQ=;
        b=eI0F3GJSLJIJtoea2MwHTKA0X0MYGhoeqVTDdRY9Qpo8NjDTNrcI65BeZjyLKPA3zK
         vPvYClaRFFFoiwnKKkufguSW564NeeGUfODkcDM46TJQDF024ipzYSUVfRJjOcMU7Bdu
         XV52OrXZTaeVkuS2glOcKhU1pDYjrPHWl48Ruq8yrfGC2fd/Llg9bdWVWLYtQBeSLH9u
         JqQgVsmbCN/Vq51XiLA31XTWEEDyCBZ1VvF393ptC1z8qjIcNCtcNHlYYpM9g5Tg6MlE
         EKwUCWwUqz4h0foBw/HqRHhdrftBsuvYXpgVdg1kNFDOYJ1hm7I7/6/w3yl+B16UzKTV
         5pVg==
X-Forwarded-Encrypted: i=1; AKwUvByJwxPodP2aOCkn1sNj2lEmiOGOVV0s2q14ISXuSNtIIRi61Hikp4okwF/O/d+PR7yoNywIew4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhomja5KtZbAazge2pie9Mv/z+iv7GQjSC7+EvO12rnGVA8KFq
	UHzzGJCNd21tWctBYD0SzCNOCzvxygiduIPv/it4iJs9LtzgSYhqfU6LyP5NK1YA
X-Gm-Gg: AYBFou1SFVAwHJVILIx6F00MjvvLoeCZ8cRZ3BHnTmD8GoIieVNM6tMg3sxCGY7I6p8
	JFiZHWX011MzTMCDFPN1HllUJjSfU8KT5dx1d5F913+MLKX92nQ+iw/kOxqA3OxEB8lBBOHO8ov
	rzB8OdwGjEartmWk+CUgBcRODhV9plQcbzf4Q2XnmHoTkpasy1nWa/8cnUge+wOMzjRmIG1C6X3
	3raGLurocHM6IxxGb3Oj8PvM9H+yDFwZ6JjsEgDmjBGRDxmksJtrRDlGbFlY+hD3TdGrddtICmp
	PMKvpddcBdkgUG2/nKseYgN8Q1mcOPL3YqgZLdDRrwQDRv5VrSwMGuVnsqJr2kgu+giGYOS+WZ6
	cIuuY/+fOrAAWd00o1s17wC7dYmrwmnfxMflUldK2RjOWPpre1yPIPRSA092Cqd3V0mLDbjtVzf
	h40Buq0ES4foPPz72VeHVWhmZDV6BVYbwdsHudS/NVn/nBGt9XNo2xy0Yxa3CIOxXxp5P0MAb+5
	bCqV/QM39vxtQ1Hhlndlk8Ka+sNvc9G2WgrlajgfpzS5YYRP4BOFv1xJo4hvnG5IK2ph/vPi2S5
	4byKbeGVAQmhMD8lyxbhuJB5276ijg/RcvZHqIKmapf4bY8nM49SRhCOFYjM/+LHKPlh+GxmnFs
	=
X-Received: by 2002:a05:600c:19cf:b0:4a0:1c43:3c04 with SMTP id 5b1f17b1804b1-4a18e4a988dmr71338785e9.13.1791616173605;
        Sat, 10 Oct 2026 00:09:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d3f-0d01-48c7-5d76-0ec6-9dac.310.pool.telefonica.de. [2a02:3100:9d3f:d01:48c7:5d76:ec6:9dac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bc6a484sm117254135e9.2.2026.10.10.00.09.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 00:09:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 6.18 158/403] rust_binder: reschedule node refcount update on thread exit
Date: Sat, 10 Oct 2026 09:09:28 +0200
Message-Id: <20261010070928.87491-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261009140955.775132646@linuxfoundation.org>
References: <20261009140952.119038291@linuxfoundation.org> <20261009140955.775132646@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[...]
> Cc: stable <stable@kernel.org>
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://patch.msgid.link/20260903-binder-thread-exit-node-v1-1-be09ff14f6a4@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
[...]
> --- a/drivers/android/binder/node.rs
> +++ b/drivers/android/binder/node.rs
[...]
> @@ -725,7 +725,21 @@ impl DeliverToRead for Node {
[...]
> +    fn cancel(self: DArc<Self>) {
> +        let _drop_outside_lock;
> +        let mut owner_inner = self.owner.inner.lock();
[...]
> +        if let Some(node) = ListArc::try_from_arc_borrow(self.as_arc_borrow()) {
> +            _drop_outside_lock = owner_inner.push_work(&self.owner, node);
> +        }
> +    }
[...]
> --- a/drivers/android/binder/node/wrapper.rs
> +++ b/drivers/android/binder/node/wrapper.rs
> @@ -57,7 +57,39 @@ impl DeliverToRead for NodeWrapper {
[...]
> +    fn cancel(self: DArc<Self>) {
> +        let _drop_outside_lock;
> +        let node = &self.node;
> +        let mut owner_inner = node.owner.inner.lock();
[...]
> +            if let Some(node2) = ListArc::try_from_arc_borrow(node.as_arc_borrow()) {
> +                ds.has_pushed_node = true;
> +                _drop_outside_lock = owner_inner.push_work(&node.owner, node2);

I object to this patch as queued: it causes compile errors with
CONFIG_ANDROID_BINDER_IPC_RUST=y.

The upstream commit was written on top of dbb17c9ea756 ("rust_binder:
move (e)poll wait queue to Process"), which added the Process argument
to ProcessInner::push_work(). That commit is not in 6.18, where
push_work() still takes only the work item, so the two new calls do not
compile. dbb17c9ea756 is a performance change with no Fixes: or stable
tag, so I am not suggesting to add it.

An LLM agent assisted with the review and the build test.

With CONFIG_RUST=y and CONFIG_ANDROID_BINDER_IPC_RUST=y (x86_64
defconfig otherwise, LLVM=1, rustc 1.98.0), "make drivers/android/" on
the review tip da42e30e9b04 fails:

  error[E0061]: this method takes 1 argument but 2 arguments were supplied
    --> drivers/android/binder/node/wrapper.rs:86:50
  note: method defined here
    --> drivers/android/binder/process.rs:172:19

  error[E0061]: this method takes 1 argument but 2 arguments were supplied
    --> drivers/android/binder/node.rs:740:46

ANDROID_BINDER_IPC_RUST depends on !ANDROID_BINDER_IPC, so a build with
the C binder enabled does not compile this code.

With this patch reverted the same build passes. It also passes with both
calls changed to the one-argument form, push_work(node) and
push_work(node2), but that is only compile-tested.

Thanks,
Karl
