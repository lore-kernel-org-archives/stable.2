Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598187;
	b=ojcP7wK2TbxReoRRpBaZT7gaNp5lXxq0C0tI5wXITGsV90XdrdL7ejHhNlcAwouWmJ83
	 vAKrJVVvqqdQnximdEvv5Ux4O7eV2o5b6FQs/oemN15zw9PZco2JtINVW/Ftw7nqZe73i
	 +hCmwyLsFTqwKgYcPYqGO5uuO6t1mzmbRXe7IMChKSXvHjQ7PwVnl9aI4/6D7f5QE1dUp
	 9IviJel7ypIE1ruuOtFh73Z2UVBW3ZDtDyA9UK60pIU9RrcAEmfa17zH1gTX8SfKHPfLa
	 K/c9YLtwh2MyHwKB2glvLfUue+r6MKcd5GulWkrtWSw5bZRCGJPtgVKzpVVbD0G43lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598187;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RkLRb1AO6/6MmSkOF6Sb6DP/sut6jAgwojvycLMAE+s=;
	b=3fzCawu3ojjDlC3VYoPRTtCV6DS12F67gJnRNfOr5Z8Irum9v3EsrtiMxiUZid/f7L0S
	 RFyDrwpzfT/P+fQ0TQsdkaDiyd7Cigwx2Nrsf6vhTZSTbARXa5gQt/z3N7pm+1Nf3hqby
	 d0reCRhyF1I21zeUCcG6zYTrdCp8ZeeFzrBIz63lo/9X9KkLVZy999I/r4tJvtwWdcpOz
	 mjHJjGLQ5XvWgvyQPLCY1XpdBKCbZzvE1AvRoYlYy7Xm63o7Mv12AZBXQu6Qc97obHh8J
	 gSy0D1cLy4JC8k3/sHhJ02lLEn/RIbL66UmuBqkz4RnfO2VbuFJMO4Y9J2+mWnQulfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwaBhbQa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1F606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwaBhbQa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F070A1F000C2;
	Wed, 21 Oct 2026 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598186;
	bh=RkLRb1AO6/6MmSkOF6Sb6DP/sut6jAgwojvycLMAE+s=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=VwaBhbQaZwdEiuqCwG8PtsGLWYvcvA11EVrDArR8pKho7vcnc+NQ5jzfdv+mh3H43
	 hZvREB02ccNT8YZfxdqHWh5W54Iw26VI8w63o2cE8Fn+YaPFtuh6I/mPS/oK6+5P3f
	 B/KZtaKS6M4ngQvdyGbtZT4yJUq0Nzoz6SbENRu8CdcTSaluwfzVpyM1iOioMxdLYg
	 RwkTut34ewNPBBs0Iemq6LTcJUu6m89B+vCL6Wk0WM0XVXjXJxNuJkTH+NtMDMBazH
	 RaKr74LHYQK86/zojN2M+AxuwqM+5oDu+vFZxmDg20n5yH9F5vlo/cLh22bTyD9BYn
	 6D444gJf/0VEw==
Date: Wed, 21 Oct 2026 16:56:23 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] perf: Track the perf mlock gift separately
Message-ID: <atjgmVe4OycVbqlU@gremlin>
References: <2026102117-rethink-jaybird-bd86@gregkh>
 <20261021155349.1698340-1-ljs@kernel.org>
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
In-Reply-To: <20261021155349.1698340-1-ljs@kernel.org>

(oops sent twice by mistake, my bad :)

--
Cheers, Lorenzo
