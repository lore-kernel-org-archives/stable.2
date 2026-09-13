Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AF3EB80D;
	Sun, 13 Sep 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325375; cv=none; b=MCs7hIiLp79MbfA0GOH+5xtv2tmINHetJSOhM9KqFY2tnO6xvucis3+rAjzdLuc/ScK8rQzVwBaTex3hX+7cLHLBIQY1C8GmJOCi/StHjsydBJrwkOseAOP3FNsrdxEMr/6+u984xM5e06zB+SVeAQoFQWsyzHhZk7+D/b9VAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325375; c=relaxed/simple;
	bh=ASqH2opBRIlLEsueKOw7/l+ZMjsrPLzg0iHEi3azRhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwZTEGE18g+HD9w7R0jlXhNR08mv86MLnUjzL4d7IUDF6ie3i5iu8qC/b3eFzPIDf/RjpOhwwskCKIZsZjx8zTgGRFnHD1WdmrA5zXuNoy3+jenFeUH7rdFNRjrWgUUZRePvmZFDg/hAKFMRzlaItIolOM3HjY/Tk4b9VvW7uAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFRxiGvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFRxiGvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717231F00893;
	Sun, 13 Sep 2026 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789325372;
	bh=ASqH2opBRIlLEsueKOw7/l+ZMjsrPLzg0iHEi3azRhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SFRxiGvjwDh+Y+1T2fJ1/aw58TKDIFHaBrbZRrT+UzodT19W1INReS6lIicR23TT2
	 Q0972OJsaAemnju9rB2GkRyKMJkEzlhbpdPs4KEvEcJXeNe/NIC0YVc7stUSSvCyVj
	 2/q8JtOvq5touWQUHq85LonqAym+Q+CrQU9/zvQSkcsrgiGzHOAQ3vOESVenX3h8C0
	 DOaXND6FYi3ljHem6MSczwwBW2UjTPmQw1VqvF55Wf1Qp3HYfD/E36aoK+sYC09n73
	 MaH06+tG3v84lMrCvA6cjKnaUCDIuBvDtySuHpj/DCtTdRheSswI2QrmbMRlSaUb9V
	 g271a4fZWecvw==
Date: Sun, 13 Sep 2026 19:49:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] khugepaged: hold invalidate_lock across
 collapse_file() readahead
Message-ID: <aqbwKLwMss-UG4bU@gremlin>
References: <DLEBZ0GIGNQ8.17U563YYJ37AA@nvidia.com>
 <20260913163644.122133-1-ngocthang2710.1999@gmail.com>
 <20260913111700.6de78b5834842f7dd3f12d07@linux-foundation.org>
 <aqbvFtlXd3Jdnfbm@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqbvFtlXd3Jdnfbm@gremlin>

On Sun, Sep 13, 2026 at 07:48:44PM +0100, Lorenzo Stoakes (ARM) wrote:
> somebody who has a

Ignore this incomplete thought :)

--
Cheers, Lorenzo
