Received: from mail.scd31.com (mail.scd31.com [205.209.125.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD8361969;
	Thu, 10 Sep 2026 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.209.125.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005565; cv=none; b=kLRqhuo4cylt+T0FoTRz/+CDoQE1AfE2mCFp4jop2COQk6QZylQA85WHTBW5fdZq1bYw5m7ud2y1WnSdKL5qa/DT+wyc8XxqzDvKBdJFsgnr7m9MyTqI9URV9UKeCInz9nuZFNfaF6vdRDoNf4XGvgjbgmaCffc+BIEfZp8iM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005565; c=relaxed/simple;
	bh=BPTlFatxbnqCqBdnyDYxPS+gQfFaoRdqwdLHQi5jO0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/aY0psQ1ZbrfXBUbEBq70kDBPqtQB9HEtn+2yPl8LdoYdHliXXNzfbrjmWHJnIP+iSCeQW7ByQxsHbjlUYIsVvDInjewqCJdJqWvTn1TUwkPZT3Fb5B8m13n1xRLOAkzUUxlf3yNUUN22XK8fAHHd56eFZaB0+RG8p2btI4+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scd31.com; spf=pass smtp.mailfrom=scd31.com; dkim=pass (2048-bit key) header.d=scd31.com header.i=@scd31.com header.b=ZVLzAZ4R; arc=none smtp.client-ip=205.209.125.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scd31.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scd31.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scd31.com header.i=@scd31.com header.b="ZVLzAZ4R"
From: Sophie D <patches@scd31.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scd31.com; s=mail;
	t=1789005562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPTlFatxbnqCqBdnyDYxPS+gQfFaoRdqwdLHQi5jO0Y=;
	b=ZVLzAZ4RC8fSUuiOan9es7jr4+OyYMKfEEE4uQUOyG/TulU+9tyV0ZJ8+HRyY3z6yutBPM
	VHXYrAub9QxA1m6Y49AjtI4SqrcOpmqQuhLnkk1uJh5S9Bl76TO5Gcg3YDWVUAy+QKgzi8
	LSbyEo4mH3qIjEE7p53dYJu6XCKyJp5KlY7RlD/BSnMZGiyaFPQKvlzxyzCZMJZCid2rA0
	4DziuMbMkR9Pm76MB9MOydjfBTmrab7IHbS+WXT1QCU3aB/zsnt76ERRXsj+sWSrG1y7KT
	kFUrLCLqjVGoOyX7cL2n7R4B9zuY/V4CLywT9ZH/s3UnDA1HmVCp3AGdgvPNhw==
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/gud: Merge damage clips in full update mode
In-Reply-To: <8c592732-6025-4073-b075-0e3e6911c935@suse.de>
References: <20260907230849.31032-1-patches@scd31.com>
 <8c592732-6025-4073-b075-0e3e6911c935@suse.de>
Date: Wed, 09 Sep 2026 21:59:22 -0400
Message-ID: <86h5jxsw79.fsf@scd31.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

>
> Such state needs to be checked much earlier. Please set=20
> plane_state->ignore_damage_clips [1] at the end of=20
> gud_plane_atomic_check [2] if in full-update mode.=C2=A0 The damage itera=
tor=20
> will then do the right thing.

Thank you for reviewing! I've made this change and have tested it on my
hardware.

Sophie
