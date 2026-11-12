Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517782;
	b=pfNIwZqc+uTsHrTdoGlLD9C9RY+6aN80TGYTmss2/IR1T/55F60L7bkmzVVsWKNTYAIn
	 vt9qZk+K7g+qK+BlFZH/XRiAs3YYftTc4vdp+VhFaHiu8U7NLYs0MWG+YPuKcNwibdY1A
	 0T1UuVMkPE6oYDC8eh1sX8tWYvDyGiEWeTWhdTCb/3B1gqMJZvOsOKebptHoXjzB0wyK3
	 qMURP5DjWN+F6SdrEWXTwtrwTRAin77secXFnbrS5lsTYpVCg5aTNPXi6aWW+PA6ROreh
	 dwTbHPpkdz5vk/cMWfepChcAyc/zvGiDj/f2eQx3CxSzKK7QQDeiRzNbWl6ZiQgCUKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517782;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=tOUVzB4J9fBxK34rdGh8gqk8uwigLZnMilMZaiZkt+u45RzjpNvNon6Sj/njjX0gCIWG
	 AYiKp5xVh6Ba0IrPMSmdfPgT3KMEnSjFpcGg1tLMGxIVF6wUN1WeLaH/ppkjLq7YbBZit
	 g8gli4k6rWLvyvpWA3k7cZfGyKZDkDqfPekx2NKHY36YhZMq3eSkBCjVQR781+BPQlgpI
	 d2mAxMkXOUwWD3QRegfuXm4q3UKmT+VoiVbzBbQwyl7qsvFqVaCYuw5mIP0WumrdaHj5I
	 Z7YlP5MrH3dW6zuU9B2vGmlC6HmOujuBlN81Elf7NPnnH2KEASCinTF7QCrVR1QuUWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B28606A31C;
	Thu, 12 Nov 2026 21:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B28606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 127766732A; Thu, 12 Nov 2026 22:09:39 +0100 (CET)
Date: Thu, 12 Nov 2026 22:09:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmet: use overflow-safe range checks in the
 file backend
Message-ID: <20261112210938.GC11078@lst.de>
References: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn> <20261112220106682vEsVrn_uCY7k7JVslANjN@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112220106682vEsVrn_uCY7k7JVslANjN@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

