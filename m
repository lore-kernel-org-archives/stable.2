Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005608;
	b=xa4B4o+Pp3+XAy4lORg4g/TtSuLA0nO05zXfkHZCiD/++a0rDe0QUp3dmLIn8xdJaPNo
	 VgL4HNqtmhlYstoybTdN1tk8xx6VoBO1PxLoAnZgbFRYrA5Lc4kMc3SMxNVHzViMvGM+P
	 Bfp4UVN87UJg7J31zT0BDGI32PDrvoOMOqlJ5+tmENKVgeh1n2clZn4m6J0RHljsoUBI8
	 URN9KdbZ861oh2XrMmFA6btrQXS9xjrNVqpzh+iXOhH0sNgn/0YgRcpv/4SHdfPllBxM+
	 gVjRgTXm70je6wKzDmH3ooeV8JoC0Lu9QTMx8W6cUB/muZWInQxaOGokRolA2Y5i2nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PNzZC5hAAUPm8hagDzWfswwarDZOjyDnhlyjK2j2MLA=;
	b=n5uHK2Z4DlVDE0b7Hwxj4+KxADk5sbM7ifsvOPf0S5GWzuwczB1tFQWQLTfAGz6AIFy8
	 ESN7UmJU7CO0rn5f6AwJ1ZphAOwGA3Qa0iaz2hl5AyVFS9lW9qD4vTtMtw3Fu/a/O88hC
	 pUIgtEkMHZoLXMpQAihmcAu428c+mPFtrdq1TdIPXVM5QPRopXMtLalqYRVdhMvmKlw9D
	 W5VQ6HmD04snPK1AvPrJhuncVToe9CuoD7l/PSHAL1SLqOc0RxnhzNXa7PwBlEeUSyKHy
	 mvMeWextgDUL4f+4M9T99ZWrhH/rXvVb8ufMJo9v+wuxYTV9JxhX0yfbG4vOqmBnjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5saEf+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42540606A31C;
	Wed, 18 Nov 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5saEf+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584CE1F000C6;
	Wed, 18 Nov 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795005608;
	bh=PNzZC5hAAUPm8hagDzWfswwarDZOjyDnhlyjK2j2MLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5saEf+PwJCVHoBF1yTSTwXJjbRg6LWrehFEnDCa3KEao6dA+T7Xly6dPaV1LQMfL
	 xjy6cFm+jR/znshJMg6jcgXnEOqzl9a2P+tEMLjMnZDX+0Bxx380P+sFniF0I+p2Ee
	 rSRZf+16xNcDzJsTsVwVcUxAlTc2kb4gY989ZFykEovdeRv8j5FWbV0mZ1Q5UT+uwi
	 Kl7VsDjtSRT5nIsCudMvm1+ACk2lQGCI0U0TBjk3ONmh8ZHYT0K1nE6gOAocKsumXb
	 61qdZOvd+RdWIVeHwMZlA9DMmVAAFGSPMiDqB+caP4TfvFdwrqsakNaxoDHGCpr9xQ
	 ecjt8sQonpFKQ==
From: Sasha Levin <sashal@kernel.org>
To: Daniel Vacek <neelx@suse.com>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Chris Mason <mason@kernel.org>
Subject: Re: Patch "btrfs: use bio::remaining for async checksumming synchronization" has been added to the 7.3-stable tree
Date: Wed, 18 Nov 2026 07:40:00 -0500
Message-ID: <20261118124002.3727477-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPjX3Fd6-adZNF1hC2n1BPJW_nDOH9yGgGbpYnEY3AUnn2Jd=g@mail.gmail.com>
References: <20261117144250.1672000-1-sashal@kernel.org> <CAPjX3Fd6-adZNF1hC2n1BPJW_nDOH9yGgGbpYnEY3AUnn2Jd=g@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 06:25:54AM +0100, Daniel Vacek wrote:
> This one is only worth for CONFIG_BTRFS_EXPERIMENTAL builds.
> I'm not sure it makes sense pulling it to stable.

Dropped e54f700d6ae3 ("btrfs: use bio::remaining for async checksumming
synchronization") from the 7.3 queue, along with 57c6777ebd24 ("btrfs: consume
given iter directly instead of copying in csum_one_bio()"), which was only
queued as its dependency.

-- 
Thanks,
Sasha
