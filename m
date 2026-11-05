Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865491;
	b=4tvLuWjMMjk59HbF7+azLdnXRneno1uoUB6DvhmcLjJC6zImZxWL07wRxd1gFxlz7jKk
	 bkk2uGXEKCyaM8Bz9VDS3GzJ+bWmAsPw6hJ4NrK8DjJbFMZj7iPmiKaQuhsuy3RIv3FUc
	 aRB+1cQG6rWUNm3Dafb2t7mKsMReJzzLVNo4VBQerPmhGtFn4NnNz/LSn7stXwQTU9fPs
	 /2AGsEKQWJEmHYiO7Nmk/uDvE/QrRwupz7VVaAJUZLJrvVq0sWXiHsr0RcFqE6eej1uDl
	 toENbq2UktBv6C1BRF8X9LcrzW7u9qW9v/osHkWjHTB1hLPxGhCb9vstjzH4sUmgwtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865491;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=uAHJIdLhyVMy3GPtTO+k+RQih6NbbfBUwvQscFrTKkzTNmznS+61kA85Pohqhg9oP+Qs
	 XFWYe7L5JBNqhW/mm7jJBuDbxWx+DeZs0G6qcgG5iupdTLU4VLQpz6stV3Cq4GazZtH3k
	 TDLOM/mGPCr5VJMUHVZpKtAGMJQM7SU65MC/NN6EjA/6n9wxzo9blRevCLjRk4SQy3sXO
	 v7168VnkzIayPzQmf6mruTkl5LmTpdoXvfE0dt1WBoAaqIlxWs3iKaXGIWMqEXT7kBrpT
	 773HXskMzVLtftj5VJ/gEmfWJTfynOBEgb7I5Ja/JzxEOCyYTFYGMcghKyrUvW6ZbEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF47606A32E;
	Thu,  5 Nov 2026 07:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF47606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4691868BFE; Thu,  5 Nov 2026 08:58:07 +0100 (CET)
Date: Thu, 5 Nov 2026 08:58:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmet: bound the traddr and trsvcid configfs writes
Message-ID: <20261105075807.GB18009@lst.de>
References: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn> <20261104030727274tgEBQGKcKOwkQ_xIxqIhN@zte.com.cn>
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
In-Reply-To: <20261104030727274tgEBQGKcKOwkQ_xIxqIhN@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
