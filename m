Received: from mail-pj2-f26.google.com (mail-pj2-f26.google.com [74.125.227.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDC420482
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598724; cv=none; b=WPjeakQxR0Ob5akvJK8DRumcYS9PAjKVGQ/f0jrno9VWxtB4sV25lpsYa5MUX0EIGpqJ04SlDaFUsv3uDgp5REusZII/+XDx/Zw0UbGN5LTkzujsqkb3baK8Nq1Y/1PPA6QRH4LiG6FgSXyoxdqjuNRtid7GBWQ8NhSDKk+wvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598724; c=relaxed/simple;
	bh=DCE6FnvywonaznENZKMO/6ORfAMl58VppAg00A7jaiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbDNwG9bMPF2sK7b8XA3E3Ue5TtuF8XYpfjszzbTWvZc8m/h4XqvZSApJfBJfV7c3dOXr99Fe0AxQRyhk/KWWhKRQK3ixOZ6UrgcN+VFGMur0z7RP5M4bKeftHTzGBdDEdqTOJa7xqKUEiarQ/Bs5FRmKaSoXgCGDW4rmkUxmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKgnadFJ; arc=none smtp.client-ip=74.125.227.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKgnadFJ"
Received: by mail-pj2-f26.google.com with SMTP id d9443c01a7336-2d8fb334e72so2108445ad.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789598713; x=1790203513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HodbLW2WeOC+F5Igytr4/ZR9Af1xRSrYgRD/3purchM=;
        b=RKgnadFJZeAd/0u72rfzHcFFADy20tjbKmPbjp2OrwrbiVUd7d+pRD/FIS3kbKmNir
         Sa9ZzlVazywjI4B0i4wgNtMywUiLwu7agl1xCjxRXPLl0FiDMeL3fXEuQss4L32XLf1f
         YqhjpWTVaQLA1G1w0l9/ujeRyoylZzAakHcTiXRkjUxyan8Q82M+Q1RTLczAsCYuj38r
         FiQulGGHV8PVNbkMAzvwlNbSofPTAFyUbAxSZwxlkzSWGBUWTv0DC4M1vmYIhsY1DQNt
         cvFPlaAfnaLoexHsYPveOCqNiRHwSnaz0KTea1OFQCo34mq9wQozoDoMNW7ZiFyaFH1c
         lXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789598713; x=1790203513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HodbLW2WeOC+F5Igytr4/ZR9Af1xRSrYgRD/3purchM=;
        b=x9K2nDa8xp7RMSyKRbKMawOOSjF607Sp+DU/qpgri42GOopgKNrE3t4QMMXcbv1e5g
         aj2RiXXGvnPX98XJUtZjgpeJhZ7HhjTMh8MB5DWINtEhZP+Z/oYCRGjf8PeDbID8cut/
         tKRGHvbg7/oqedRCgbTaLf8CcRvhuYOmtEQpN1ZiWW1/UOvwqa8cDf0j9z9SqN1aLWtq
         C8fgYObUAFKee2kMu2X8Br4T2InxCaZW41IiYRH3wk9f8bkHOHCK0InBbI9hfhyWOvYn
         e5ES1IqXACwarqLMO1767YzTHmBMr19vlVrqrW+U+Zf7sHPQ7YdOIdO8Lyckv/Af/J3x
         sYlw==
X-Gm-Message-State: AFuF++nBhuxixRmW6leCIJXjh4/2nDmoRgUFNomJZXIRTtpHX+Tgi9Qz
	FSFISjaMYhd/S7bXdmXojTqGIfDOIvcE14kGc10ZfXr2EXnP8DqznIYb
X-Gm-Gg: AYBFou35khpyXUNHerFeQZr4PkW1o59muWgYfTmHpLW+kfaukpJSWmD1d3lXQhE5p43
	6LQInUn4fhTxgl0Qc/J/aeuZJUwIX1qU8qfma5rBjS2UAqYvQ2myvlVJjNEURFdxJnG06aYuwT3
	JusfXBBzgOGSe4v2c2OnxsIE/FEg13R2UAn1YnGq0v4MAOQ9iMtvFl2Al1YGmcTgbNqQi7MiE1B
	1YaIPvgbas4DEwf4dtBoO0Bs72YdKI8KwYsqdjJSxFwbk1Ss7SavHP7OB1G2BAnFs2VnagWMB9H
	1fHNix+7inupjrX8O98gC/QVM1+TLa+6z5muYz7sPt5OTJRE0GqY4HjpSmBuxKLLWSqyXr8rRp/
	GAAdzYz4vVXBIUFxxpP5MW69CujIzNp7SMh3AjEZZRAv7DJeSXtKcqKsoZ4iq1p0SRmrnOqLnRc
	GopgnAwgqKzLv7kQYSey50BogJB9AddCmZXlHMJ1qaDkJjtaPqNvyLy3j0GdYcvL6TlDkcj4Bqq
	yUYdcJY/S8cmLk5lra2yc67fpvfy5LIiGGU+UMS1lA2VUc2hjKWpBdOgFN5bX+0Zjr9PVNlOprD
	GWTdonrSM7+NErqsnLgOlUw+Bq2aUsc2FGCYP6hXu2OGOK00NO7/wLs2
X-Received: by 2002:a17:902:ce81:b0:2dd:64:12ac with SMTP id d9443c01a7336-2dd8e632d3bmr86301035ad.11.1789598712717;
        Wed, 16 Sep 2026 15:45:12 -0700 (PDT)
Received: from Cyndaquil.localdomain (c-24-56-233-47.customer.broadstripe.net. [24.56.233.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8e6a3sm17609805ad.7.2026.09.16.15.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:45:12 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:45:09 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Tianyou Li <tianyou.li@intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18 1481/1518] perf annotate: Fix build with NO_SLANG=1
Message-ID: <aqsb9cc0sIUtI265@Cyndaquil.localdomain>
References: <20260912065623.398859879@linuxfoundation.org>
 <20260912065657.062881527@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912065657.062881527@linuxfoundation.org>

On Sat, Sep 12, 2026 at 09:00:50AM +0200, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Namhyung Kim <namhyung@kernel.org>
> 
> [ Upstream commit 0e6c07a3c30cdc4509fc5e7dc490d4cc6e5c241a ]
> 
> The recent change for perf c2c annotate broke build without slang
> support like below.
> 
>   builtin-annotate.c: In function 'hists__find_annotations':
>   builtin-annotate.c:522:73: error: 'NO_ADDR' undeclared (first use in this function); did you mean 'NR_ADDR'?
>     522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
>         |                                                                         ^~~~~~~
>         |                                                                         NR_ADDR
>   builtin-annotate.c:522:73: note: each undeclared identifier is reported only once for each function it appears in
> 
>   builtin-annotate.c:522:31: error: too many arguments to function 'hist_entry__tui_annotate'
>     522 |                         key = hist_entry__tui_annotate(he, evsel, NULL, NO_ADDR);
>         |                               ^~~~~~~~~~~~~~~~~~~~~~~~
>   In file included from util/sort.h:6,
>                    from builtin-annotate.c:28:
>   util/hist.h:756:19: note: declared here
>     756 | static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> And I noticed that it missed to update the other side of #ifdef
> HAVE_SLANG_SUPPORT.  Let's fix it.
> 
> Cc: Tianyou Li <tianyou.li@intel.com>
> Fixes: cd3466cd2639783d ("perf c2c: Add annotation support to perf c2c report")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This appears to be the same patch from [1] that was previously dropped.
With this patch applied, I'm seeing the same build error as Jiri Slaby
did on the linked thread when !HAVE_SLANG_SUPPORT.

For now I've reverted this commit, but I wanted to surface this upstream
as well.

Thanks,
Mitchell

[1]: https://lore.kernel.org/all/2025121754-breeching-aftermost-d10a@gregkh/

