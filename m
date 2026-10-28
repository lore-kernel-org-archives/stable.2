Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200167;
	b=wPbloa293zvtutbe8gQOJK8my65okg4n6TMkQ6gDEhg0C/5H+0SbEWZYVsYjgVHJgVd6
	 Fzx6SfAkqGiYu3FyRYQpwuLRw8QqjrrqdXylBwXSYL0qcl6nxai1Sik+0Dklb04Ezvbxi
	 GRncn/88TmYPZicgS/Cl6QDN0kY6C54NKy9JA6mVaLob+FsYORnbGKFRIlD9M4yoDfddB
	 h0rizFiTkzMBu8APqDwF+jZBToFHkJn/GyPUK0Rr6w4iQXwCV9n3PpZfwHvPo8VkzCP1H
	 GGSnSG7BsAx1hO6kVAIopIcdrP11Zv/fpbg1UXLRTT/qG0YDfdbIuJugsxLWSZuQ2qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200167;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=GPY3IGo2F3N9Hy6t+k8/GOxXcNDzY+Br2QWYaBcnXEFo2USf9x2DLylL02jIwj+ZSdjY
	 xgZn8Hiv83NP2e34qMkNUZRXaFl34gwWqdJH+2KzPxVFnRSNR5YBlG4eDHEr39HQRpz7u
	 DR3ewnLR8NPEKi8nCR+t1G7UL6sTa+ZskAc+D0JD0Uhu+kJjWMM7Q9VfRHzTg4bZ0OlEE
	 NZsZa9UpOpKLsIaqrTCu+GP0IuZ3wI8TAvzXc+8OdMnnrkrOdKth1KKt+jf7RR4vdvAf6
	 vPaVEGc0ySauZgSBlpyxLg3/gWKo4el2NPCExLzs0qwSwV2oZmlvReWcL1UOdTF5Z9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB0606A31A;
	Wed, 28 Oct 2026 15:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38AB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3590668AFE; Wed, 28 Oct 2026 16:09:21 +0100 (CET)
Date: Wed, 28 Oct 2026 16:09:20 +0100
From: "hch@lst.de" <hch@lst.de>
To: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] nvme: release passthrough resources before user
 copyback
Message-ID: <20261028150920.GB16374@lst.de>
References: <cover.1792118770.git.x-professor@outlook.com> <6cae8c109686ff0fb71d4b69767f9abeb45be74a.1792118770.git.x-professor@outlook.com>
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
In-Reply-To: <6cae8c109686ff0fb71d4b69767f9abeb45be74a.1792118770.git.x-professor@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

