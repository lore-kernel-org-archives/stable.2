Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9301E5702
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435713; cv=none; b=qo3KeJEzZj2Ox9urEwRR2bk+n99+r876rxVEGI8I0luIijoQLnArJud3OPxNzpaC96vkGt93UAiAeGMstkyLHJngOpOv6KDXouLQQrcqhtH720QmXvKMe5F1DxP+Z8H8+gasFpDaJdpWzirKc+7tikAzk/XD6GKnR9cXn4+zUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435713; c=relaxed/simple;
	bh=Lsg4j5eFWvMqIbEJyOW2qo0hHFj3gbtonhvxLCJ8LwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kqc8cpYC76k+wqeXelscbb+pYDDBAQN5P0v8GxcrWs7uLXWuy3Zq8eX8ICDiT2xEq+Viq/tpD6N6VRieZygaWYtfSc+9AQ4idLecMAqMNqrxBasqYOFpA2jqGop6rU76FHQ4GxHnYH7CSrKI/fgdieloH7QNO+dtfcPAiQw4Rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzD1POnF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmMi6If9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzD1POnF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmMi6If9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783435711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Drq9IO910KDKJg6IREG7IQQKNNio5SvfjReuxq/0qk0=;
	b=VzD1POnFW5OZi8ODFPNLGnViaYsF89+MagFD1VEbFRnm79+NNCvMvwCpduddj1s/wqeiHG
	bGEZK3c2LBkKjTUsPZQiqUfNQvNu6rLtK6Y0nXsQZ+cEuvzHFOkxOhuCRssmcETU8Yqcud
	uFTfeDi3n1BvDqrDPUpzRmD96L5hngM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-9gAFqDnSOYaP523PtwyvCQ-1; Tue, 07 Jul 2026 10:48:29 -0400
X-MC-Unique: 9gAFqDnSOYaP523PtwyvCQ-1
X-Mimecast-MFC-AGG-ID: 9gAFqDnSOYaP523PtwyvCQ_1783435709
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7ead3468408so2743355a34.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783435708; x=1784040508; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Drq9IO910KDKJg6IREG7IQQKNNio5SvfjReuxq/0qk0=;
        b=WmMi6If9qUlI95dYQXfhE2taaDkyWHKOST9WGosrY4MFCAdWoJoFq4Ka5UNjjvnrvw
         ZfAFPpdjhO/DjJ+NTp2fsCLB8pWruQV9tlHzAvtxzLvx4ru2jx/BQ3RmQJ74kXxU8oWE
         ma6Mfljk4eLR8oP1Eoxb0Q+9oqd1Ufs/oN95KNg9kOpqxP3PATIE1A44hchyAuQsfSM1
         OuiKCJYLqtx76jkmryrt0rbLUFs7H4BrSAtuQJzLSUmWfyTEQG1/YSZVXI63B12Vp222
         Yn4K8Q7cscCh4Yn/HEOHsjHfVdSZ32fB1VgTgvvt9uJplf8m+RFlDIsYnJXxDeMdZS4F
         gfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783435708; x=1784040508;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Drq9IO910KDKJg6IREG7IQQKNNio5SvfjReuxq/0qk0=;
        b=q72i7yQQEdbizgFjhp3VZr0h+JQYrJCoyLUnYEX9W07nl9ZNh8M01H0ezRblml80RN
         SI8c5BpJUTjBIWYYL6gY1plAdTfjt/01AxMqhovrmHAd0VftzSc9xR1cFYTAyu4jvIx/
         WIOze8nkpmz5ddaBAk6YkYm5Np3ZEjkh5OWML45EL/CcjJa1W5VDjs31vCOAZXdhyIFn
         8CVZmaVGydkDYymUFcuNDoQs4ME5b6NAzK1vCR9MiVax7ayJXlbpQkFE7l+N458v9aa6
         6fod77huzOSi1XdtW1UpVsmngxZOIBuCKdT67s7daO6Fg0FC2pt3Hf1xZ9wHLwB5ocd3
         Eu5w==
X-Forwarded-Encrypted: i=1; AFNElJ/jkDO8/jU/P0nJV7hOzECWUw8pv3iNX4kN8zYssueMHw4GCNIoBwOD2f9HJb+59I4HPx0kvxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1U9dPZvt1gQqGqzXQtxZdW/UQmAazwNLN5OvBkhWZwdWSWQOd
	tpFTZ9Kxp2ik5rIlN4b+EI6LSdC26Ya3bA7EXpP2+WfcZFCbf2W+7r2EmyKRk8Jpch2+k3aDUWv
	udS1F0K9PVMZUstxDtKlLhLdbYQKup73hyKSkYzFgrmtIfG0hiE8+b/sERg==
X-Gm-Gg: AfdE7cnkkoFPm9pnDEXBPEmqcZqgRayR2IfkLpn7ormaydgHOx0lIHj01J8q6WPSMgC
	XuUuWYqY2Eas/5zxuPM1m7d9hYJ2tbiYBnsHUvynS+mP7ULsF5tN7YR+JfcIHdXuqpbDkdGvTdb
	czeNp97uwL5B8qMywpO6piJuF0CFKMLd1+5jZ8RhIN1R/oSST9xKs7H4Wn84XqQXuAxXOAwDNsx
	8nixG2Ka1dDi3Pm1f9QlMCFK2owljioy90F06+1fc8YAPcgNJJxkX2bDKgRVXX3R8GJsw6xRKPe
	9Cse6fmyBfNZTl+7FVO4q1nmKcf+33qJJKf4nW7JT59bzlEySperr1dcLPiWWWFHqNxpCTaXgT2
	LEs1515ar
X-Received: by 2002:a05:6830:660a:b0:7e9:f0e6:fd55 with SMTP id 46e09a7af769-7ebb239d6a4mr3693033a34.30.1783435708661;
        Tue, 07 Jul 2026 07:48:28 -0700 (PDT)
X-Received: by 2002:a05:6830:660a:b0:7e9:f0e6:fd55 with SMTP id 46e09a7af769-7ebb239d6a4mr3693021a34.30.1783435708164;
        Tue, 07 Jul 2026 07:48:28 -0700 (PDT)
Received: from redhat.com ([2600:382:850a:55b4:731e:b0d4:e0cc:410])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542936e6sm14104096a34.5.2026.07.07.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:48:27 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:48:24 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	stable@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v2 5/6] clk: mediatek: mt8173: fix memory leak on module
 removal
Message-ID: <ak0RuP-Gy29fpPVi@redhat.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
 <20260707074839.240676-6-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707074839.240676-6-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)

On Tue, Jul 07, 2026 at 04:48:34PM +0900, Akari Tsuyukusa wrote:
> clk-mt8173-apmixedsys.c and clk-mt8173-infracfg.c do not call
> platform_set_drvdata() during their driver probe callback,
> but their remove callback calls platform_get_drvdata().
> This results in platform_get_drvdata() returning NULL,
> which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
> This leaves clk_data unreleased, causing a memory leak.
> 
> Fix this by calling platform_set_drvdata() during probe.
> 
> Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

