Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099692;
	b=mw51c8hkDxO/++aX9ujed0ZeKlj8iTZmEpffFW8ATPrFZwQM3eAqlaZkpZCK8WCAlrH0
	 muvpVFJ/7abek9+enKTwaYhkfr/Ne8g+YXkRa1OLtwlgM48Qtkwac/uXKs071nYPjHhD/
	 2NHZy8Ykyy+QpiaGFPfnx0/4cvZFazzO8cU6/tBtrkisRmE8Aj0g7PwVwTjJH6eTrGvaN
	 aF4HUPUP4daWMfJTVEuBBXjd1JpHCa8jMV/WTi1Jvetpo77I+MS0mHn59vgzq6WzkNmv0
	 WA71cFhBX4PUest5SEAYPfVpQ0NwLOREQ+Au2yfW1hdHcQTTK8a79vq3csmvuRSzSeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099692;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=O6gRNTYxms5NJYh1H6e+b86VMQtiJrvze8fWfJuIGYg=;
	b=Hqwn67xCP52wcXwW0+ZKxpJWClgYvkZY0607wPv11Womssa4odRoAIZE6q/5+QiqIDle
	 ai7X1ivkZdSNGr49/X8uMG7cWMfxvAELVFRL5DyNhYn8myF0XCeHSrgEKMVae4fbm6/4U
	 VIc6bBzRcRROLeMsWetnRwxYEoMe3eJvQjq9dolsDzlj2a/bWOct6IrmKzbjVO3afyc1T
	 uBFpufPWLnHeZT+8JvfvBfYRnaovz2mKKRcOjRSTV8RRTy8BnzomuLGgGYH5CK74k4P/x
	 M6xjUm2pDTbvMO8gXl57dNnM/A9TJv/bLitlyJi0ojAjVfiRhyFtQ/GNIpfRwAv6cqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=TipCgdHu;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F6606A32F
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC3F6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=TipCgdHu
Received: from trampoline.thunk.org (pool-173-48-114-214.bstnma.fios.verizon.net [173.48.114.214])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6AJElcnZ018018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1795099661; bh=O6gRNTYxms5NJYh1H6e+b86VMQtiJrvze8fWfJuIGYg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=TipCgdHummTbeWKleXn1GQCVWQ+CcwdOPz6CrrGNJq9yJNoEHfAJXulhz8owatlU5
	 cu7huE+s74VZMpoKcfvQ88prvMh5UPjbFqFRRf+3KoMPY3+ukDZ9goaGeHTdhDeb4T
	 HXEON8klRHiWzXYF6qxCM8Yzb0voQc/vlVUuEmfp0Wkk6Cxnmb/OJRuj1zVr+MEw6K
	 NReWVqr4mNVecMEu+rsJIjAvoYz41htVm/PEcELIUeuwPekDp96CjaQmYlTZCqAT5J
	 2RZyZ7cpuSykSGa/paXYKNXZGwmWI769Jcy3c2zJLhTdCfkPjAZZOpey/Ev1O6Ld1F
	 8/tlDxmggn22A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0F8F22E015E; Thu, 19 Nov 2026 09:47:33 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        guolingxing <guolingxing@tju.edu.cn>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Baokun Li <libaokun@linux.alibaba.com>,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: record writeback error when discarding pages on failed delalloc
Date: Thu, 19 Nov 2026 09:46:55 -0500
Message-ID: <179509948709.1938961.11162343670709084796.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016110311.71391-1-guolingxing@tju.edu.cn>
References: <20261016110311.71391-1-guolingxing@tju.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Oct 2026 11:03:11 +0000, guolingxing wrote:
> When mpage_map_and_submit_extent() gives up on a failed block mapping,
> it sets give_up_on_write so that mpage_release_unused_pages() discards
> the remaining dirty folios. However, the error is not recorded in the
> mapping's writeback error state.
> 
> If this happens during background writeback, a later fsync() may
> report success even though the dirty data was discarded and never
> written. Returning the error from ext4_writepages() is not sufficient
> to notify a later fsync(). In addition, ext4_do_writepages() may clear
> -ENOSPC when committing the journal and retrying, even after the
> affected dirty folios have been discarded.
> 
> [...]

Applied, thanks!

[1/1] ext4: record writeback error when discarding pages on failed delalloc
      commit: bc6d92e3cd19ec6b20e66c8cfee3e1ecb5f6e778

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
