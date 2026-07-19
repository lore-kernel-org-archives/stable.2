Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D23A1684
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473252; cv=none; b=OsDzsR5CCGzHE7PuNXem+d7ORoXzZmMJeObLRnTICxwzbL0+QY0DdqwLJT8YhwRrfP1kuBPVzxWjpqxdhP7AKqXZ/HnIVWvgbW6SuetTx5hQ5+I6M49gcZETNDMpv4h/6OR+iICSaV+0L5fxou4DOs30YPT+zFWwieWOmDlm914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473252; c=relaxed/simple;
	bh=TasdsgvqIUlJ2YWFjByuqsoHqd/bUOItTTKjDyOStKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiNVHV/mQHiONowuQsN+JKPq375n7AFh8//9iDP9sMnr/BsBNpZvgJAK6uSTl2HYPX6ih7pHw5pJ68Ntn4+nyguZz81brHjWkWcUd1CMd7bg2BRss5b/fpw8LVZGkBsUXE7o3c0BRVqan5rFidVJTygc5VvZllKADGaMQR554OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io0ofVE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io0ofVE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2B81F00ACA;
	Sun, 19 Jul 2026 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784473251;
	bh=8gYGMISry2xs9B1EJNjGuCFPdaFr+BSrV4JxwCe1eaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Io0ofVE+a2OzbQb3Fl2GtrU3ZDJIOmgfoQRE0EVd9cHctAvMgjR+aFgWyYbsudyOJ
	 19cdeGPRzCu8vvqw1Pv0K/05dsQylU9QA6+JFV1FG3oW/PAeyThXVmna2ywVKAF3Yr
	 U1nyMXCXCZ5Y34/d0/KifsE8S9p/GVJQyT+nI2tHhmMPx9Dwl/NeAKPsChpmpEFvW1
	 o8Ap9338uA9bc1uVlcJrp8qyvX23b3yuABZvuYIGuLp+ST8FNv/I59tJqgEiulT7qU
	 3SNCgKOcff3kne7XU3m1ZIazruuplu45UbiFFLR82dXoBRVOt+zLmY5YU2I7Owmana
	 1u7q4XkFA3Zxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linkinjeon@kernel.org,
	Yuezhang.Mo@sony.com,
	Rochan Avlur <rochan.avlur@gmail.com>
Subject: Re: [PATCH 6.18.y] exfat: preserve benign secondary entries during rename and move
Date: Sun, 19 Jul 2026 11:00:24 -0400
Message-ID: <20260718192718.0010-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716165127.2998-1-rochan.avlur@gmail.com>
References: <20260716165127.2998-1-rochan.avlur@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit 8258ef28001a ("exfat: handle unreconized benign secondary
> entries") added cluster freeing for benign secondary entries inside
> exfat_remove_entries().  However, exfat_remove_entries() is also called
> from the rename and move paths (exfat_rename_file and exfat_move_file),
> where the old entry set is being relocated rather than deleted.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
