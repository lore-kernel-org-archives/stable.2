Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361015616AF;
	Tue, 22 Sep 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091550; cv=none; b=JzZMBiR0J3RaKXnxu4QCZw3RVGggvuo7R7726wsqiiJQVFqiQigbQOTcXgFbID/SaMH2ttsLQ+iO2rTiiT3zK/1rzub0en5pDVHjZTU4/e3s/sc70A3f+3ZsnQIVXa1CQB68DV3XON29FivSCcJEI7b2jFbe+NR6ZXLhWetzOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091550; c=relaxed/simple;
	bh=KH+B7SbGvfIoS+B/U4oJEyS+GtfpLDgbOS/S+ok0zbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT7KPweUEUuOywGH5umUSVqSf6XtKopbg1LUBuKXrTgSz/faBd3fgUpZouElslqyYM2k42HbmS1qH11T9LWt/I1pjaMH7L2ER2dagTyaei0SfIIn3Edr3rVyUWWmD7Yg222fZqaQMjorNJGJLc0ckhOZlSjsK2KYXn9vAnUBGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzvVo+AD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzvVo+AD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A431F00893;
	Tue, 22 Sep 2026 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091548;
	bh=VvGgsBScOUiiRtEYk2BKlsCaEdrW0rRIRoHDQQEhzYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BzvVo+ADdMbNZP2XxPMpmhPnLnS5skNb0JUj34fqcy6ZJxtQYhxA19FFIgIAx+2f9
	 Cu9QY7Z5TAwkLVbfIkyQguLnPFCkyG+ImGrl48kkvhuCcsFhqvwuLMp8qhA6bkMgKN
	 uxsJlMViqwjx21Xs0HikTGW/uyw6Ud/JVSJLt/SDCu3BHuPD8vZtq0T2rO3KZR3yix
	 DJ/YbZpBmJAKvKdOqMOnJxXsrwBAgDQOrXtxf9nvw/cGuzyonnRvcoJX7ZzNFY33j4
	 wHDiSWUtyzWqkxtGiTyz+8ZiCn5AGs3Nmr9Ofq82j+q4Xixt1nzkUhUvs9nH39zYGW
	 jKFqh/DvslJRw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [STABLE v6.1-v5.10 1/1] HID: logitech-hidpp: fix race condition when accessing stale stack pointer
Date: Tue, 22 Sep 2026 11:38:57 -0400
Message-ID: <2026-09-22-daily-reply-0004-re-logitech-hidpp-stale-stack-pointer@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922081615.821827-1-lee@kernel.org>
References: <20260922081615.821827-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Lee: Clear hidpp->send_receive_buf at exit label in hidpp_send_message_sync()
>       as __do_hidpp_send_message_sync() was split out later in 60165ab774cb]

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
