Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E2517BCF;
	Tue, 13 Oct 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904341; cv=none; b=EJmsR2v5l6V+X0Hd1vhtzaUS/rgHEeNrO2ZLbSFZB5H+ffCMYm+xskrt41Wxl5TKvJbbXxCfOwc97+BABv090EJB7pC+nM/P6MXGXoSIqNQYGMakcKm9bqcMw7lQlUdL6UXKnOuMil9ZBPA388aPkfqE1ZXW0Yi4ylBuTW6cwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904341; c=relaxed/simple;
	bh=Q5ojD8krtc+Aao6lRyqsW/wzOgUxEecgOimL8EqdajQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ti+XAQOnCFhtOHhBC3IiL361iGkoEXhQ+TNosgRNsmESvJ5sshgzGcfVsEAshYfxmDQnfpYLGA20ZzHR7iBLTXHX8sUGl+RoZ6k6BoezSW57PErKj1GFRUzpX36ZhBRZNE+dCgO8LavvgnKjLr4qhcnHU3Nt9YfPkvIl+9mdelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUYw4GGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUYw4GGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511BC1F00898;
	Tue, 13 Oct 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904340;
	bh=HwNY1rgM6q4Ctj/+3tD0gRogjIimRT6p7jVBUT2kqPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XUYw4GGNTknWnm65i6mHq+XLq9CcfwRdNYS+uR0S6mPSBSBLfdwVmzXO8EiGiPfxT
	 6JJJ8/AdSVzOEvFRwgN8EAb9ag9sKNgcb+WWfUKYL+1UCcmoEUVqhd5huncqDVVdbi
	 qeDUhKZnj+MXP5OfWjtyxYc7Nd5hMzmLy0aIDKZFkyry86AMIZ/5XYIpClsnQSwmvi
	 HsI/LEP6Ysr8va2NNnSuqMPSVRsb68bLrkcAEFGkrgi9fl7qEUcpGeE9u6wSHLvAYF
	 Cx5/Q5qDlMsJiy8/jvk0q6r4WNpJoXqIOHEWYvqOqw7F678UilyZa9NhOuAVi98d/O
	 M2B4UCPriv3hA==
Message-ID: <1b4ee842-844e-4b6a-9ce8-0c4e7229825f@kernel.org>
Date: Tue, 13 Oct 2026 17:12:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvmet: pci-epf: report transport errors in command
 completions
To: Christoph Hellwig <hch@lst.de>, Andrea Parri <parri.andrea@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-5-parri.andrea@gmail.com>
 <20261013142736.GE14759@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261013142736.GE14759@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/13 16:27, Christoph Hellwig wrote:
> I think this looks good.  Damien/Niklas, can you test this on hardware?

I do not have the hardware available right now. Niklas ? Can you test this?

-- 
Damien Le Moal
Western Digital Research
