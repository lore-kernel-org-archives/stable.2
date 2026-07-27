Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A63164B4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190789; cv=none; b=kz5Zfl8dxUMPeoGPa2STZhcrhTFG/Wv8K1JGfRzzb+mNIdAyTOhEgBU2qfiiL3oKh0HDwhRHVMtVu4Vd3ceMUmm0nr2i5QUkBBecNXvMLQtlJ7nJBa9pEAIvdhJQBd9x4yi7lEUngQMFBtF4yA7s4QynFll5vIJP48GuZfatJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190789; c=relaxed/simple;
	bh=/ihhk3AxCYHrdMeL63eVSI7Oz0OrYZ9S5h7YHfCbkqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnO50NF4QNzpsFbVtPrf6UEczGeb16USwRA6ZnQ+zlGjswD7J45BYf/JEA1jWPbjuVM1tM8mvWT1lPV0rcV9VtpEfJRaXebSO1+iAJ+MdylUd9e7Y1KRA/Vz2EBMwn3B8IP8bljL1A3K68cP/hjmqyQdUXr9nY5O0RJpSK6iADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK4/CPsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK4/CPsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008F31F000E9;
	Mon, 27 Jul 2026 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785190787;
	bh=qz5yuk3Olq+M8jLNfqF2OW6+i4vsEgqvrnN4rGjgJM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iK4/CPsRaw8tsjB9S5rIPlAu+Hf6USsY7Yi4Ha0AwNxxY72n8mkM7/ZU2kKbF0gfq
	 1VVbyI/BJcrbxNUwn1+exbsPR+0kkTz66Q7R9u6xOovOPTOMm2olC08pp+J3P8z4nk
	 /iDfjjqW43Ws3XK+MRTN3AQJYcuifAtJDxd4z+R4sEaduK+yVlx5Ibs4uI0siSkMUo
	 guHyeBk4sywp/RX6EFHbciDBTztvq78HW/9gqWf5kHTzhWiPjKoam3ZfDB+8/RVVNr
	 J2UmiTCCEr+yE3c4xCFyxi9RZOWMeoBfouMQxpuT/lkaD7Sds35jXkInpLNusRmL/H
	 52g+4ToBWhOZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	1141866@bugs.debian.org,
	Lionso Alejandro Pacheco Vacacela <lionso@murena.io>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [7.1] drm/amd/display: Add dp_skip_rbr flag for NUTMEG
Date: Mon, 27 Jul 2026 18:19:34 -0400
Message-ID: <20260727202413.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1bfb3bb0dda1f5cd66ca8a48de2536c026355ded.camel@decadent.org.uk>
References: <1bfb3bb0dda1f5cd66ca8a48de2536c026355ded.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jul 26, 2026 at 04:06:49PM +0200, Ben Hutchings wrote:
>This ended up as commit 9fb646bc4d87f62bcbf0a7ea326430eb802c475c in
>7.2-rc4.  Please queue it up for 7.1-stable.

Queued for 7.1, thanks.

I also took the dp_skip_rbr follow-up that your subject line names: it is
Cc: stable as well and it rewrites exactly the lines the fix touches, so
keeping the two together avoids a conflict in that file later on.

-- 
Thanks,
Sasha
