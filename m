Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DA3803E8
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190791; cv=none; b=HhlrTNg5Fh8et23Ver4R0UZ63QMJmvjXSzQmBdlhOoLg86msgkaE8aB4XnWYIgM+ObzUOVJgCnwSwgq1q1uSybmblLq/NnE2LItELSjS8AARKLajapnPDk3UBBxQiYqM4qnge7CPb7UTjCL1X6n59Jw1Io0aICONC8HGFa6zrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190791; c=relaxed/simple;
	bh=OPF+gfn/RPgT3sMBASxQU0TCqz0+3bLye83s/ESgijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtldqLeuLYiUiAepXN07bglsB+P7T0GloKFtT7PK+8Dj+1e2+qyOMxY6/N0AsQcFutiAxA0HIDsbSsK9ErLu/5HcC/OhxFEHbvqmCayeJaPwIgTUt+8Wcrk2unYrw2BCdIzHxGS/RyCKWwoUU/7N0W0HPKfbDlhojHavXjz/i8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+C5FGtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+C5FGtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BD51F00A3A;
	Mon, 27 Jul 2026 22:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190789;
	bh=/ySMc1CInLqBSodVoXS0csNZHbKql/mETz2N3L8tBDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+C5FGtJsYESixDmeLXsx7KIf+av35vGFPMzbW08Jsi7Dm1fxog+cBzpxnaIHfAhu
	 xerm06x31eAY+kog9XsWVECByCs4L/3A9KhKOD7MAdB39OrVXjtFfE8DG+9d8SBCb/
	 Gpx7kxSGb55w1dd7YqxQNYZNLAbS996e2S7gJ+271YGyFIB23Yz9eQnVpulMUvcePv
	 oknuL3wAFrNGHzVJjC4K/FvZDQfNV+KaR5JErsydJAUBBRpVOpSnxVdt+j6Vp+sP5I
	 s4uykMtwU9YpVpnsbKVwSRp/PoQ9Gqyc8FwJuUWaCVbXdtJAhBnwKvHG6ZcAgXioyb
	 IYbXtJ2oF49uA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	jwlee2217@gmail.com,
	oleg@redhat.com,
	qw3rtyp0@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH V2 5.15.y, 6.1.y, 6.6.y] posix-cpu-timers: Prevent UAF caused by non-leader exec()
Date: Mon, 27 Jul 2026 18:19:36 -0400
Message-ID: <20260727202413.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87tspkiyrt.ffs@fw13>
References: <87tspkiyrt.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 11:10:14AM +0200, Thomas Gleixner wrote:
>V2: Fixed the old->interval fallout - Sasha

Queued for 5.15, 6.1 and 6.6, thanks.

-- 
Thanks,
Sasha
