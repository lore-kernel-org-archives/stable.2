Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5F3F86F3;
	Tue, 13 Oct 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902012; cv=none; b=Di8a93lmdSyBlCMWr7q4fZdFKlSZ9XhNyMGsPK7IrlJ/tBe2nxZS+UyrKHEnsXVUGBXWvTPDWg9fMISD/+ulsHYorO+Xajn5TY4wznBkkyl7XbbAYYzrwFxV9b2CuAiE31q3iP1qPbMzOblIwkG/SmKz29oaLvfApIRub0V+N2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902012; c=relaxed/simple;
	bh=hISCIOq3zZTIeWuECdggdpzdSfCe3bOvUSju4mOZVMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONfZ77vvZSEpIEPwzaleyZ4wYrnCCtLmWlS8oBqO38pDcS1ZcugkUu01WOEdsekKp9NT41DQqFjeG/B+KMHfC0U0IlEkw2bzmELhyBLeeJ1abOjXY6btU14NFuTWnTHzwJehfmpOMAOAIKC7eLFJ0WfGpybJHEjrSfFBS5QpibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2385227A88; Tue, 13 Oct 2026 16:33:26 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:33:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvme: keep a private copy of the effects log in the ns
 head
Message-ID: <20261013143326.GB15395@lst.de>
References: <20261004072052.1574-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004072052.1574-1-yogeshgaur.83@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Isn't all this already taken care of by commit 72ece656abd4 ("nvme: fix
command effects log lifetime for multipath heads") ?

