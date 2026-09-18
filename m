Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4761375ADF
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770480; cv=none; b=Yvm9Siu0wgVmgrT/tghFtT+TbYkGkzsojsTttXhBFgeGLy1OXDBdMXxdQvPiB3JBn1bAqyByZeBP03iNejhVDLw7vQuuRXJ/aL3fiEbUufyz3ywkk82k3WIPlO7vFmOY83fy4ouVSc4OPqq4/y3OHr8i2PGa2lYaOMeMiIaTGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770480; c=relaxed/simple;
	bh=NGIFwKB33NxQy+k068R4T5Tm6/ogvoilF+pwjImbnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d90lnWCm+0coj0fkysjDp+1U7TxespsgYvnCUnmcAecRcY3wunCQns1EzZgWM6WjXQX+qFnJDWy6L5jcHVVa5OdgZ8RILItWih5OfrR/7g5hOkRMgJ+/CExZjhbxhOcFoF7iTTZomKTAcOmD/2D7PDM3ul3tJU6ZpdpbDyxQ7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KohRcIls; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeJT1TBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KohRcIls";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeJT1TBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789770476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmUqK+rq52Mp671nbFhAqy/BcNTM6h9Cl3CLl+lByKU=;
	b=KohRcIlsj2Xw/mHhaFaC+4+1iyzZAV5REJigf2h1mlmAz+slLKoxpKQPPiU3Dz4OBibvnO
	d4BrHvIJXzqHweKyf/+Z/gIx32Gt2V4emBOx6RryLL3upf0KzrpK4IgleXz2SwDR8thYds
	kIBfpn0MxQ2xu+XDZ+lPSlt/9TixzXg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-jXVbMAyANYawEClfwKTYog-1; Fri, 18 Sep 2026 18:27:55 -0400
X-MC-Unique: jXVbMAyANYawEClfwKTYog-1
X-Mimecast-MFC-AGG-ID: jXVbMAyANYawEClfwKTYog_1789770475
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-530e5b709b1so25606131cf.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789770475; x=1790375275; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmUqK+rq52Mp671nbFhAqy/BcNTM6h9Cl3CLl+lByKU=;
        b=UeJT1TBKtDviuUFICtm1oioVac1IdX3VT6qTKrTwTCsG9E5M2e3Czm38oAntgzsT+q
         dkyOAyukQpgbpnhnl4Oz2XyWBb2mZhwKtjQSkCdHEJ5hOqNM2PYPhdCYHtKK6brQBWPl
         3wINOAng70nK5eUiQ5rh8fuRKvFK66FkErkOOaCLQ7FqY0U+CtQ6CUTUTEyJvx/1g1uM
         DuhWdlS3QuNVqENd5EeFaqI5Y6r/f20KYMdAHGYxhhLuygr4zX0oQ7Lc0laSMhUKNtwk
         0tJqF/DNbctVIRpGcJU5MlcYo8GoP2cCLAHqP80lwdQt45AgUOsiRXHcUghOfZAHlw7N
         GYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789770475; x=1790375275;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:content-type:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YmUqK+rq52Mp671nbFhAqy/BcNTM6h9Cl3CLl+lByKU=;
        b=VCD4YpP/rtlyYJv4rJNG8uQUtqLzRW+BE9nyHdP0W1+dDze20+7jzUBUv97jVUz0EE
         m+0tnP5UYVMJmD4ZKiywhN3j8irl6WSlH4nxm0KqVHqhtXYxorcUDUXUd/dmjdt7g0Ng
         HxHvmVkkEJ6be8WHNktzE6BZrNZfB25PfRMxCHNSQu4jWv2Gxqhrv5cCZ35DBcj928eQ
         WsjwOdAWVrYAj6Dz9df96hIVJ4qNwlCFv3uV2Y3T4gCjTH+TUAFYBZgGTwKs2ueX5yf+
         cf1JXo9dNymWVKZf0lTS16HyTxJRV08DVDU5NGwnU4IyUKM/4t9ojVp7luFkief6yTMB
         vY/A==
X-Forwarded-Encrypted: i=1; AKwUvBwffNVCF7W/FOV19EBU9N2X6Jf+1382EhatmKiak3dMwz0UVDeoharHCVSJmNt3uBaZJX2Xhu4=@vger.kernel.org
X-Gm-Message-State: AFuF++myZdskW4X5ChV08XoyHLdcPx9BgR0yTn7REQRm7Q8FyWMuPQ32
	92ocJ5GTy7qV/HzpLUCuAVxnv5K0O4TEnogaOatMvHU2kbAkvVIpKVbnkOuAgx2oOhZ55/370Yz
	wXUIjXeemgmILZIo2Tacc30mw7nmXzJCrm+sRg988DyJdR+lcmpKXoKN5tg==
X-Gm-Gg: AYBFou32nfmM7Z9JSOMb8kvl1qnWDmSaR5uPjoBD8JeY45X6Bwhkm38yXR/ZQsSlykd
	1P6MjpRTEm/7CZ5IRWs7Ch6lZs+wtO1pTaK+URAGd5tt5//7zsTRQNmuJzYliZOsDVkWf7yA6DO
	a6c/zdwcprJRviq0B8Wr8BbHIZj3IAl492ytzvBZkRtL2N/xKgHcvuOCoLRXiIZYLMFARz3UJLw
	UmGYsSbltv9ur3iYIuGtJmm7vkjxcyW/UKgbFq6MccoqWM8SpVWlo+pmXTMJjRWLu0nND8Iv+hE
	LC9ujdKnGNrzjyVYLGyHk9tE5Hs+KiXrH6F8scrwzgR64qAZTvj/Sp6+kQFB26c2TNuXpMw=
X-Received: by 2002:a05:622a:2616:b0:532:9ade:b6da with SMTP id d75a77b69052e-5329e557017mr77338911cf.67.1789770474810;
        Fri, 18 Sep 2026 15:27:54 -0700 (PDT)
X-Received: by 2002:a05:622a:2616:b0:532:9ade:b6da with SMTP id d75a77b69052e-5329e557017mr77338571cf.67.1789770474435;
        Fri, 18 Sep 2026 15:27:54 -0700 (PDT)
Received: from redhat.com ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae750977sm7202701cf.23.2026.09.18.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:27:53 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:27:52 -0400
From: Brian Masney <bmasney@redhat.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: versatile: clk-icst: Fix node reference leak in
 of_syscon_icst_setup()
Message-ID: <aq266FMPwj99yVCz@redhat.com>
References: <20260915070103.1733176-1-vulab@iscas.ac.cn>
 <CAD++jLns9S7ba9G+wcnsfrDBjtDWbM-qzg+NeW9vHFHKcOz3NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLns9S7ba9G+wcnsfrDBjtDWbM-qzg+NeW9vHFHKcOz3NQ@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Sep 16, 2026 at 07:25:39PM +0200, Linus Walleij wrote:
> On Tue, Sep 15, 2026 at 9:01 AM Wentao Liang <vulab@iscas.ac.cn> wrote:
> 
> > of_get_parent() takes a reference on the syscon parent node. The
> > reference is intentionally kept on the success path, but the error paths
> > return without dropping it, leaking the node reference. Release the
> > reference before returning on the error paths.
> >
> > Fixes: d430819d69a5 ("clk: versatile-icst: add device tree support")
> > Cc: stable@vger.kernel.org
> 
> Stable? Really? It's no big deal.

I'll pick this up but I'm going to drop the stable tag. It'll probably
end up there anyways with the Fixes tag.

Brian


> 
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> 
> Yours,
> Linus Walleij

