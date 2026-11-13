Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597021;
	b=QN+fTduNXck9GDZr5jB4PD8Noya1q0U0rYNj7k54cvGuG7NvpVvh9zgWRFvDt473vy8O
	 s8qO2tI+1F4devIYVMU7J0ChCl17//eVf1fbhX2Cc4Aros1sNwhaNkNTv1nhlwErSbwXJ
	 N37r53KRI81tpffVlYj44n+vK0fkHaMzcJI203RK4jUrQ1GPTZFsUv4RZr3ZHhbs9E+mi
	 SrO3ANCsvch9+h3lNhC/ZuuTx1NJ/SfcRz5z5kDlhX26AmBnYg+uS4dlZxNfqimKTUh4r
	 Q5pI3C6hX9tT5FDTMnw1Xtd0hXYR0Q2dtwshhqK/EbyPezgAxpUKwFNOcV7kXahfjvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MTP0CDh1ae7O7KiGC2O60r0OOfXGhPtQFYdEt2Api7A=;
	b=vzTvWh/NRUkMgYGZipo1Cz5yvHl/FHR3yRyKSZLDq8aMqZ1tiG+BbNyMhds1yfVyc7MO
	 4CQpDBcIKHjHhjjJoeua1Nv6Cton5CAXNxD0Yl8bU6ZdaEQZQHa0QcycJvYqbKMH8EsN7
	 pS//vFP4R79qeWZGrHcVCWdmTa3xtGNqLBal+jGQZPXwiRoln2NTNAAq9VWobHoU7bu78
	 bM6jaAYXLu/i93rpTkATqbN5CQNdz+I1pk47HIzBalyzY/viGCdwoH/sR8M6KOpBIPmoa
	 hNQC7DZjBC/V9nG9TgqDJYPsZkUZFV9+tPcq0FmUX/sV/M2WCdqfKm3IzxFjPk7orbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0CS6tJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC8606A89A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0CS6tJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B01F000C8;
	Fri, 13 Nov 2026 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597021;
	bh=MTP0CDh1ae7O7KiGC2O60r0OOfXGhPtQFYdEt2Api7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D0CS6tJCRAL4mDkMxJxolr2e3+NDBn7a143XjybzjeBoq0sKPe9juiub0qsnClG80
	 PpV+kObOKycc360Y0DMMfu+YxKRvTEqDGXJkj1eNDOJBi52IusMX0V9WuJg2xf67Fs
	 BZOeZq5cMqs62QFOsI1/eimFqL9ybIClr4uGCuVJiiFmjskxogcKPjBiWJevmn+lD5
	 GBo2p//vlibG4e9rDrfYn8WbnMsDZRilS4hV7qynslzNK796ZhAMlyFsgJl23nuEGY
	 u9DxUG3bjF+MYobeQhIyPmUpnmYY8XeMODUTzrvqawFJn74WRShe47rRgCRPRgfkJr
	 uJyVtkkj8sdoA==
From: Sasha Levin <sashal@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 6.18.y] ovl: fail the mount if the casefold flag has changed
Date: Fri, 13 Nov 2026 14:10:03 -0500
Message-ID: <draft-0013-regoldsteinovlcasefo@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOQ4uxirbtnBbeyHbq=gm+ttA=0nusQjsCoK0FsajZfqL1ZEMA@mail.gmail.com>
References: <20261109200525-failed-6.18-c782fc8ada81@kernel.org> <20261112084347.6208-1-dennylin0707@gmail.com> <CAOQ4uxirbtnBbeyHbq=gm+ttA=0nusQjsCoK0FsajZfqL1ZEMA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 9:43 AM Hungyu Lin <dennylin0707@gmail.com> wrote:
> From: Chris Mason <mason@kernel.org>
>
> [ Upstream commit c782fc8ada811569811c0fdea5c3412511be95d0 ]
>
> The casefold flag of the overlay root must match the flag recorded when
> validating the layer roots.

On Thu, Nov 12, 2026, Amir Goldstein wrote:
> What happened to the original commit message?

Agreed. A stable backport keeps the upstream commit message as is. What changed
for this tree goes in a bracketed note just above the backporter's
Signed-off-by, e.g. "[ Hungyu: ... ]".

Hungyu, please resend with the original message restored and the 6.18
explanation moved into such a note.

-- 
Thanks,
Sasha
