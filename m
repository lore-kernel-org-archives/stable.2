Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01799374183;
	Tue,  2 Jun 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395949; cv=none; b=EcJtvxa5OPP+1iBt3mEapIv6e6bh+zxq8c1o0ZH0CN795FiD1HT/XG+zm41ujSWmle1PUbPW15NPx0UbKDFsdDTnwDu4EfX69dHr5cuuLw8e2juAxtf7K4rJEPJDH1uJK0T5GebEsq5PSPSRExmOWKuG5uUJKIC6vB2xuziYRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395949; c=relaxed/simple;
	bh=R+NnnAbKETatYxf+HNTn73J4h7Up9CcLFedYwBvpHuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUjyAWUOO77tcP+a9vj42EFfrOM5zSZbBPy37NcSHg26WzhpIvNwIWLSmSv6veNj7zWbmiCBvLIU5ESKDElWzvJ01l2URqrOnJYlTJl8/hd8xhOlRst9QcKnBBXTNDjSuCNzr4xwAk3v4zL6i2lIQAi3EsH6ZVsRNMgVvdBR3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxWDg3VO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxWDg3VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA991F00893;
	Tue,  2 Jun 2026 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780395946;
	bh=hRPt7mzyqdyREPEGW6G3M5xYMjEjmy1kiu/DcmwtyEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oxWDg3VOdhrLnk6CH2HPjPsf4D3LfI8/QGRytvqpUurWfddEKoudjtAIIurph+Lyt
	 CkCbTJx/5PAMWghvlYTdRXpAeAEjXacWhKmw2A79V8KrN1jnkwZ2j76AwzZh+WnqvU
	 1A0vBqEysMcZyxSG/F11XvW+V96Zn4fRIgKoKgpSuRHK89uZcbnKeR8Uifeeyzrwpd
	 IRN2/TGDVAspJijA97goGwFF/AQFYeRMqHoWnd7gQ3vYUHc5xD1NIC44LJsxRFY9Rn
	 dll83oXxQeNxZ9OV+uQbwqqUBynI01Hp2/DEsjl2DxaoBGpmQRlGi2fQwJfOzvRMQ0
	 bqNjtg5Opxo0Q==
Date: Tue, 2 Jun 2026 11:25:40 +0100
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ah6vpFq3P4KnIc-j@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>

On Thu, May 28, 2026 at 03:24:27PM +0000, Achkinazi, Igor wrote:
> When nvme_ns_head_submit_bio() remaps a bio from the multipath head to
> a per-path namespace, bio_set_dev() clears BIO_REMAPPED.  The remapped
> bio is then resubmitted through submit_bio_noacct() which calls
> bio_check_eod() because BIO_REMAPPED is not set.

Thanks, applied to nvme-7.2. I had to manually fix up the whitespace
damage, but not a big deal.
