Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046421;
	b=l69HKTZ+s2ePYbtwiUq8tc4Yyy+CaA54AEKofB/SFnsinRUYiAWuFSoH+I5Flc8pys37
	 pGgjU0ru7cXoLPJwqp4dt5Euhuf8ndo9ZrgL4NmxrsvLPsKY6igd49YSYqAkF8F3/C3eU
	 yBXW4EBwllG5U8urM54MEmDeZC7AK8K5mi+YXg+gKaXSWWNiOaGv4QaKmVAWDzcQ7s1HC
	 DVNmL4HhDTVBNxAQmV/PPnHntYF7YpIEp7qSiC2fye/bs3OZ1WbAf/aIVrXbIflmsVU/B
	 shvxJJS68M9xC7mnaEqiCe74IPe3FqbWJU6iSIrFpj7xuAJDtLBi7bPokyRueSrPaZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=gci4HjhmuUam9CppAlJdjHIOy42WtCn64qZovch60/I=;
	b=L+aU9/725bjGru0PXYqdsgOak+5Mo1Tmh+r/tj3dipLRm1RngbMizxyBxEAfjs6n9TJC
	 3BnHmR2spPDpWQ31xHoDHPnmsG5Vz8mHuMdn43qMbNqv2a6O1fX5PYkVOJx+2x36oyzmV
	 QOREFmym9TF+1PKxB5HWpsJownhSlYfql2BJel5WfKCJNO9NmiCfjcPiwxv9sFkN6aFjl
	 Rvcx0ZlIvvN50QGEu4zhGbCUz95no2Xue34C8I5wVDfYh2zr9YZvp98MWJuUSRm9JCVtS
	 r6rMQp7k1T7lygCaU+1dECQkHcXFkSDlqzwvWhWqL9nbvjFTwE+1sdKzrc7K7OpaAeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tenstorrent.com;
	spf=pass smtp.mailfrom=tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b="V6Jnvs/U";
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA412606A326
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 20:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA412606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=V6Jnvs/U
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8726acc5eadso26599977b3.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1793046420; x=1793651220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gci4HjhmuUam9CppAlJdjHIOy42WtCn64qZovch60/I=;
        b=V6Jnvs/UtwB+HANezs2qBYZlab6wPp8+1quo1vFYC55Y4uY1TxJ6MU/72pdSDbcWZl
         OPmyiN1nPMjx+MAUXEWHsMnSPvG9w/mNBCiOpR/JFModLf5E5XIBniUkbXzSPQbWzHeV
         CiywYHdNVtBTJDJHfujcXZqESbDjmN3QVMBALiGFln6qTld3NlvdB7nLqoL3kmrgj9YN
         6qQzcSvy8ifU6O5oRUp+lynWH6fsECcVwgMVEWLh74WD8g3Jsn4OSqbYLtu+WVxmTvHZ
         czwPuy0mg0ECQl9x3ljXNuF2Bt3ZY5imi4JpGBSQzhaZFfgQwLjsnQN053iGB/pNXpX7
         Yorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046420; x=1793651220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gci4HjhmuUam9CppAlJdjHIOy42WtCn64qZovch60/I=;
        b=mneLxlKugn2We4c01HLSbmtINSBjLmZ0jiW4KI3nJayQE7UBCkeTQPNSoIKMkPbh7Q
         yQPABanpaTJ+3Dr0N5oFvsh2n1j8ZEXvLxvq+/POBZRmtviLSw23t9xtqJ6DPaUtI0JJ
         5lc4d8wMOBqMrg7wxF4goxWhT8KQ1sOttkY2plH3prOadUkcmr4tc4V/32/14blDZoU+
         w/DKNntFHmFAKVidrwbZPMKGVQRD+sUjUlgeod9IZhhah/RdMUsGOrmLZfzmEXJjolgn
         3sVAPoYrJ8Q1qKlK/n2jpTyrIxm4piYpqV0kiO8WozwzbDXbR0KzxSOFIGA36Ct6OlVb
         sqLw==
X-Forwarded-Encrypted: i=1; AKwUvByas1YVIEn8Z2/BnRrI7O0Y/wOyXH4mBX8XTC0nfxKPfS6s3RLVB4qOsQOiz27Na2NzbJgGIak=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRvNn5UuCTfX5fg1EsQf3hg4W19HxMW9lzJQ6sFlKKho/DyvfR
	N4y/m632Si1clS6UxO5r4PxnQPEBRDy0vxc5/K250KZjWq9KQwdJFQu2+XsWQxOFdvc=
X-Gm-Gg: AYBFou1yFok1wHYIeGniatt/gvW3RUjeCS1wDrALnE57vKpfqMhNitaf0R+frd3pmlD
	BJG37ndZkrrQ8irXNsZkVa158Jy4vOP8Hcls9q6lNO2jYwq2QTDTdfVq5k+U058rgSmgSDzugFR
	xTBFPQIyAseNcJThx8SCYvTIHJNgnJKOO5PihNHBccEZHWelYy4uv4t8zBglJVDh9075gxeGXat
	/w8AQsgBD9wGCAzj++EFMznWINzDoAi7wNB4O7OSvnQGLuHresaaKCeQaPJariz7V9lWIAonVGv
	ejUR8ngd+iKOgWqendoZS5f+z5uyyj6Fj5SjzYAwpyP1N89XyK5fUE3I/t8zlTFwWFeGL6l72l6
	6buJqRkn8w7tQZzsNBl7D2vyZqSLCgZLxT1tklfn8fx+Sb0TiiLMWf2Y+sCe4Zw1mZH3Xelj7hQ
	bse6a6y6Dopfx9GmMnRr0bG3GdXEVjwx7FStOFHFZlJDIvjm1dwoED/UzUSseBfBXcRX6+o1low
	Bw3LEx23VfZPouKJFNFgkoqG5oR4MqXheKV+rmyrUqa8/7sUKjsa5sgw8AQp93eYu4=
X-Received: by 2002:a05:690c:fc2:b0:81f:e7c5:f420 with SMTP id 00721157ae682-8b166b92716mr58087467b3.20.1793046419789;
        Mon, 26 Oct 2026 13:26:59 -0700 (PDT)
Received: from localhost ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e656162sm1512807b3.44.2026.10.26.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:26:59 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:26:58 -0500
From: Andy Chiu <tchiu@tenstorrent.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, zong.li@sifive.com, wangruikang@iscas.ac.cn,
	debug@rivosinc.com, qirui.001@bytedance.com, guoziyi114@gmail.com,
	samuel.holland@sifive.com, ben.dooks@codethink.co.uk,
	cyrilbur@tenstorrent.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:  riscv: Fix SR_SUM leakage across context switches
Message-ID: <at-3kvwKj9m02P7J@Tao-Chiu's-Mac>
References: <20261022083212.84721-1-cuiyunhui@bytedance.com>
 <atqL1ScMLUg2bM_E@Tao-Chiu's-Mac>
 <CAEEQ3wkS2niNwzS25jhvT55fSDWF_anYkLW5PZS0MsvUOq2vBQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkS2niNwzS25jhvT55fSDWF_anYkLW5PZS0MsvUOq2vBQ@mail.gmail.com>

On Fri, Oct 23, 2026 at 10:50:45PM +0800, yunhui cui wrote:
> Hi Andy,
> 
> On Fri, Oct 23, 2026 at 6:19 AM Andy Chiu <tchiu@tenstorrent.com> wrote:
> >
> > Hi Yunhui,
> >
> > On Thu, Oct 22, 2026 at 04:32:12PM +0800, Yunhui Cui wrote:
> > > __switch_to() saves the sstatus value of prev and restores the SR_SUM bit
> > > of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
> > > and next has SR_SUM clear in its saved state, the old SR_SUM bit remains
> > > set in sstatus.
> > >
> > > This lets next run with user memory access enabled even though its saved
> > > SR_SUM state is clear.
> > >
> > > Use csrrc to save the sstatus value of prev and clear SR_SUM from the
> > > live CSR before restoring the saved SR_SUM state of next. This keeps
> > > prev's SR_SUM state intact, while preventing it from leaking to next.
> >
> > Do you have a way to trigger this bug on existing code or is it the cae
> > where the bug could happen but we never experienced it in real life?
> >
> > If I understand correctly, this can only happen when the user access
> > routing volutarily makes a schedule() call mid-flight, or a code fogets
> > to turn off SR_SUM right after an user access and has a live SR_SUM when
> > calling schedule some time after. Both case should be a bug as SR_SUM
> > shouldn't live in the kernel code that is not doing user access.
> >
> > A trap-introduced context switch would interrupt a code that have SR_SUM
> > set. However, since the bit is cleared at every exception entry, the
> > context switch code would not see a live SR_SUM. Seeing the bit set in
> > this case means something is not turning SR_SUM off properly.
> >
> > I aggree that this is the better way to handle SR_SUM in a context switch
> > but attaching a call trace or stating that "We have not caught this in
> > real world due to ..." in the commit message would be appreciated.
> >
> 
> I don't think we need a "better way" to justify this. This is a bug in
> __switch_to(). One possible path to hit it is
> user_write_access_begin() ... local_bh_enable().
> 

Thanks for pointing this out Yunhui. I've looked into the code and this
reveals a bigger problem: calling local_bh_enable() while having a live
SR_SUM is not safe. local_bh_enable() can call softirq inline, which
calls into usercopy in perf and BPF. Since the later copy assumes being
called with SR_SUM disabled, it then flips the bit and returns with1
SR_SUM silently turned off.

The unsafe_copy_{to,from}_user() with size >= 768 can take this path and
calls local_bh_enable() with SR_SUM enabled under kernel_vector_begin()

I am going to send a patch that prevent calling local_bh_enable() in
kernel_vector_begin(). the get_cpu_vector_cotext() is actually too strong
for the requirement. Otherwise, we should consider gating vectorized
ucopy from unsafe_* path.

As for this patch:

Reviewed-by: Andy Chiu <tchiu@tenstorrent.com>
