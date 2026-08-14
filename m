Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADD41D123
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709407; cv=none; b=qj6Wls+p1Ixc8vDxRkseKKJo6xnUHjsRpViIhky7pFB6tgf+CHYeP1rZ1uBAeMV1xxq1g+4ladHtTgywpyYNPwpMuQCbhorfnD+hGHiWJaxfnbD6iz70WnwNWseCD/4W8e8u/bQGoNqMG3IRhX7AoLcgNVM0URkKDpXTwqNphHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709407; c=relaxed/simple;
	bh=E3YzPO3gJzQBPXBvPkzYkp3TqT3d5GVf4hf73WjuIsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nAJ10QISMHUXCk42WlBl0Pom5ozpeNSp3opJXLx9zO3ZXHM1v8YAHaa74gJA9cKEljt1KOyfBOfJCDoZMFM1PD57pk6l0m7mkHzZ+7ZvN3nUqDJQ8ACsziuUBsbNbSVbD4MAPmrdr2WCxS1Cz1zlovr6P+ExwLZ/ooaNWaNeHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW1zEQHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW1zEQHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7071F000E9;
	Fri, 14 Aug 2026 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786709405;
	bh=nzJfaLjLopv5KDjAnsZCI03u435dpJB0jWVUPJzz9Io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RW1zEQHPgY126CvaBmbQfmQ4pb9HftuuzfhHdb3iOwAj7T6nQ2APYVbVnhgxcP58s
	 fWLjjYqYGOSJnCsSD40R8W4W8eZcwR3WSjPC5wQiFN7oyNyG1MZfzBiDlBZN6Vd4+m
	 AMoViV3JfmmPM8zy9DOVJn36/Qh1vCqsskTvpM/7pj2BWsc2B9qlKVVKT62tZVTE8P
	 rnDapLRzpOuonYtFWGkyzZ13aOq58VmeWwkS4WN0omxxXAhCO5JNYzenEgOdr1kjG0
	 hgS6Uq64EeVZwoZUL64YXe9XUkdHJTLkIfnpb++n6BtJ2CATd8CzinbMLHXomtPWZZ
	 15ho3W6chdIzg==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, yaokai34@huawei.com, peterz@infradead.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] futex: Fix race in futex_pivot_pending()
 during private hash" failed to apply to 7.1-stable tree
In-Reply-To: <2026081352-debate-broadband-ab5e@gregkh>
References: <2026081352-debate-broadband-ab5e@gregkh>
Date: Fri, 14 Aug 2026 14:10:01 +0200
Message-ID: <87a4qonbs6.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 13 2026 at 09:52, gregkh@linuxfoundation.org wrote:

> The patch below does not apply to the 7.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8e7ff730dd96519a333d1570edf1c3fabb6d3629
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081352-debate-broadband-ab5e@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 8e7ff730dd96519a333d1570edf1c3fabb6d3629 Mon Sep 17 00:00:00 2001
> From: Yao Kai <yaokai34@huawei.com>
> Date: Tue, 4 Aug 2026 20:55:30 +0800
> Subject: [PATCH] futex: Fix race in futex_pivot_pending() during private hash
>  resize

Don't backport. It's broken.
