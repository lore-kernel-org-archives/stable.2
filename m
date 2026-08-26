Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6138B7DB;
	Wed, 26 Aug 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732601; cv=none; b=nRwqnTjDByYJForQJuTKhCiHPjp7DNsTivK3mupk3KzlKGDRTNX9iuE3qtSyOsiA5wnIjFwfforVynZ9HeDWeBkqddwyICCdaFJAxTFFxpJ0xv1C8iqX07zu3Uh4vFJVJBB+CMTWjK5JvnbSPBjrhy3uDVtuYNS+7Vh4E9Bkfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732601; c=relaxed/simple;
	bh=qSlNADoOyqAJEpBJLjZgDAKsxtt0+35c6vqLhuQFXYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+DqMkr2q7PGAGwmt9gG1183831ZBkY07BMhagX3hBoO+bwtqFjhsAgQk7CymNOl4M4KT5tfLb6nujWyS4Kipxvlj1MoD7p8311QT9xFYnS1QPSezNOEGcUJuoQyx7jRIVYu58F9IONudM8ZDFeE5/VTvW/FVdgZvPJQO3vY9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu/P4OIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu/P4OIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3588B1F000E9;
	Wed, 26 Aug 2026 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787732599;
	bh=qSlNADoOyqAJEpBJLjZgDAKsxtt0+35c6vqLhuQFXYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uu/P4OIRNL63avNQFUualVWA3ANWRe6rGU1tEW52kAsy3mssgrwHsPqNcVO7tqX7M
	 3vZivTBTrTm3faFZsdpzzqigGWyk2/fTQTp7xncuOGzf4Wi4iNnjjjmI6Nfys7fZyS
	 V8/R/kN744EiRsi9cKutwFaex1J83GbfqkWmq5T8nH1bUMNHmkgzIUHuTf4V5h/fxI
	 RthXtMgGZFZB/qUNW83YLYt5bo6LUx3Z38Hb2uduyhoBX8a9Zj5aiGpCeDYI2XIS30
	 YnWP4UAJarDSQExdRiMpvzcfcM3eesPzQVCJtY+BmrtSK2iV0ny5GYuoUYMi3TrgTK
	 u6KFbPVflf9dg==
Date: Wed, 26 Aug 2026 09:23:13 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, usama.arif@linux.dev, zokeefe@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v3 3/3] mm: khugepaged: fix folio is used after
 folio_put/unlock()
Message-ID: <ao6hClAw33UnGmET@gremlin>
References: <20260824092935.73892-1-vernon2gm@gmail.com>
 <20260824092935.73892-4-vernon2gm@gmail.com>
 <ao6e9RxwQ-KC1Ikq@gremlin>
 <77412338-b54c-455b-84da-1f39db641c90@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77412338-b54c-455b-84da-1f39db641c90@kernel.org>

On Wed, Aug 26, 2026 at 10:14:43AM +0200, David Hildenbrand (Arm) wrote:
> Note that the monstrosity we called pfn_t no longer exits. :)

Oops! :) Fair enough. I mistook it for one of the various benign typedef
unsigned long xxx_t decls and forgot (repressed?) the horror show elements of
struct { ... } with flags and what not.

Vernon - please disregard the pfn_t feedback, obviously :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
