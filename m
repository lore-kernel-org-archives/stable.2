Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518061;
	b=Zsfy/cfJz2B2pIar4tx9D5TlLiFyJar4wZ6o91KPfNt044LaZu/aWb3Y7pg7kGsxUnz8
	 y/lnpcSjOIAE2/irK38vrKV9qMLwb+Fe413eIueDeGy4rpInISzomUucFdW5Plkah82qg
	 jI1asQLtKJUvpTa/YcqUj+CsvzT83/chEEf/ZAZpMHvBV52tzJKXHxvUm2Bm8kOfXSC43
	 cghaVJu/BFa6J3IRkfg+9ZUR4eDWtKNNiBTFpK21Q8VLdrhKAvwm9yIE5/KjRCd0IKYJv
	 afs35Wv53MyfzBpMIv4nztfvpDW1/QeHKGqvL45t/RNc0sYdVTXhTp5HV0O345ehD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518061;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=NaocvwK6oTtNi9cB++EEUpfP+HnxH539vbdULZW+CLq4IBtlWet17a/AGu2L5fwxaMjQ
	 m/R4hjmB44QQ+ScVOtphA/+MDHJUk2aiGbFpz9DCZfrjHDbOSJCu4reXg0is1djykXjmE
	 QV9Pie8iSD8k5YpYUCqs7eHP4H1M17mPCHkUJkUmSJTr6UEeDNKECugEpBNcbTn7khDUd
	 q03eu3G7prpcEIhk/kqcYogbL/TN8bXpPM0ResHMgIuRWD0K2RyrnWL99EJIZO3liinKt
	 FRKvXfwekH+C73TgBHfXJlwrfut7JFGWTNoqOYtPSyUJE/MJ7uumW2Xl2X43BbvLFUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAAF606A32E;
	Thu, 12 Nov 2026 21:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AAAF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EEE7168D09; Thu, 12 Nov 2026 22:14:17 +0100 (CET)
Date: Thu, 12 Nov 2026 22:14:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6/6] nvmet: roll back queue bindings on connection
 failure
Message-ID: <20261112211417.GF11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <20261110230316687z-VG9wgpFwmzFNKVnMGKY@zte.com.cn>
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
In-Reply-To: <20261110230316687z-VG9wgpFwmzFNKVnMGKY@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

