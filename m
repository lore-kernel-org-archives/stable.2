Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B493644
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102622; cv=none; b=p56o5/kIqGEPoKVFVLWk2HBrnwJfXVipYgtMTUBK6EHKseOq4VaeFCEtScksJ73BexFdWJK9n/jogfSZ2hXdN1nuMopRuKW9AKOR5CDmiPgZjImi1iOjIC2ralVtCHSkeyM3EiXFXBaPIRLHDOKhZdWmlrKBKBa57gfi1IbhLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102622; c=relaxed/simple;
	bh=Ey1dVK+mA1HsYVtOFCvdCUUmzc/P02m1z+8IiV9BcnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zzy2LDyHwkWtfZxDtnl8myABUQc41hztTPdc2PNw74W9PNZGsoEmjk4gisTi40FZ8409Ip4/4zSbX5M/sK8XvKhKejLRbgkBBEPPreRLVzLYmZLNJBTQjShh7AM8NyWObZiWbB0q86W3zCGbxbJr999YoDiJk25BJEZGk0sglY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIhY44Gg; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIhY44Gg"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b91369d18so953445e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102619; x=1790707419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2l4JRHC7Rw+pqUP1HReA75dDASuf5PmXyxwWG+odoY8=;
        b=WIhY44GgUthjJ87mJUagfWsiJbK1+4UPAYPDP5yf/F4dFnzRJR/V4NQZg0m1Kv9kRH
         3Xfw8xRjWa+h2i4KdU71NHILFbpsoYTjo8/995/qPnhLb2utzq6slH2c6sNT12PpgHfA
         QIPtuW8Err3r5fSEDA/uZ6qU+O01wmGmuGu5IKhSXfTbHne9qVX8fQip8FN07atJPfga
         MwkEbNwz1Szq28MumFLMI+AVr3i7n8vLnK4R2onmvxxZBJdD8/X3uf8oLtQSqse3/5Gj
         +gkzGmtG1O8p3GTHf3E+nE5yc/j/1yPV1ZvVuMpzWMLWUT35KN9DBmmEsLAuImAbgBbh
         XKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102619; x=1790707419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2l4JRHC7Rw+pqUP1HReA75dDASuf5PmXyxwWG+odoY8=;
        b=S14EHWnmikoKyYviVlAkCi6Kej6ZmRYrR9yA1QqMdMDuKIs7kCkZcbs6sef7RzlEqu
         jZGSuF91gpc0A4PKKaSBW8M7zNhX+jHPQEbCa6LR6jqrKke+rweBFHjseivoHckgdUbi
         O0ET0DIW9f8zZEET5etR70+Zo3uSi4inrZYfi5QIILawGOhuHBgdBSeY5rmRmyN4h3vU
         GHe3jwGSi/DrX4Q5psPv5rH7UINvpwxi70NwqK3qcwKmv4BO/RkoMak+gzxO4fYBKDRJ
         DMjWHZx2tRjnS0mZl05Ya3CMOrJTnnWYuHqDpKUpxolynYG/CG4Zu2RODBGp4x4/Z0Hc
         0skw==
X-Forwarded-Encrypted: i=1; AKwUvBzhgabcbwjagN+aZeQwnWvt0QJGcMAErMkuEsAoJaw1ZkQbPHtbmFVJKWY0fns4KWcVp9tv3OE=@vger.kernel.org
X-Gm-Message-State: AFuF++lVb24dG0jFXN44MvYrqzvJwgY2Fa2BBT9pXnhb6bbfw+70W9Jt
	CoNIYNCSQY4aDlcBRf4eO7fztobPwdYq1tFTeR/rATfVXI52oX7A2MVc
X-Gm-Gg: AYBFou0i2VRi5/wWHsAOjbJanksduAi702Ohs7R3sOWY3CIKF3OGzkNRixZBWax9drG
	JFZNXZ8INoptCRjkT8yo7fd6BTw4cgVjpcwclSJtrXglGVk12X6qp0XK9saYfQGDIm3/fuR7jyj
	TtPe57+GPYx1f8nCq+09W8RJQCarQaNeC0zIno7FXwHCK/3IauZqhhY9jPaInrslozsiq3bISup
	5xGwASh3jrroTqAXY7fD+JRxcl+VjzeFOJ/8r6sbAMWJfC2qZVoTEUFI9/2ulTEX6MpZt8XA00g
	Qsc+wxZDov29RlC1ig79b4CcalviNPGFutDT5AoGkU6MSbRHSwKEJpapNjysxLprwVGhahdBD1M
	Ea+cFB4f0AmgTVjLAissnLAYnSEh3WGrrIWvvl2vav6PG5Kbbya+1ddC5lzLAnLRgmX18/ELvpw
	cn6Nt7bKq8Yy2VesE+jx2FXDRC/IE5k1Z6PM5CehyycjxtdJsZyatmatZuPAovQChLmvwm6qc49
	W3/5HhJvlZQxAYhtWcePXQRDai2SLZRrQBy4hGobWvQQJs=
X-Received: by 2002:a05:600c:a06:b0:49f:cbf1:e765 with SMTP id 5b1f17b1804b1-49fdec980bamr2359185e9.0.1790102619110;
        Tue, 22 Sep 2026 11:43:39 -0700 (PDT)
Received: from andreayoga.localdomain ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18093csm13157875e9.3.2026.09.22.11.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:43:38 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:43:34 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] iomap: don't lose a failed direct I/O bio's error
 when zeroing the tail
Message-ID: <arLMVnDWlXPD1iB6@andreayoga.localdomain>
References: <20260921083133.2960-1-parri.andrea@gmail.com>
 <20260921083133.2960-4-parri.andrea@gmail.com>
 <20260921223432.GO6283@frogsfrogsfrogs>
 <arIT5A3MR7VtCeba@infradead.org>
 <arJF9USiUqIEWB1M@andreayoga.localdomain>
 <arJ0eljPZIuj5PFD@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJ0eljPZIuj5PFD@infradead.org>

> Please drop the return value from iomap_dio_zero entirely.

Done locally: iomap_dio_zero() now returns void, and both call sites no
longer capture or check a result.

Thanks!
  Andrea
