Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584422E3F0;
	Sat, 29 Aug 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974491; cv=none; b=CBrxYBj+a8e/r2XfTteEvezmJZ97a1KYRK7kp95lZUOIRFthdNHwKNPbsUngGkFXwhMBAc92BCbifsmytlqT8PeRnWtj46RhZ61BDHArDNVaepUXQsQP8EX/SbCM67i80PgyMwqA6/Jhf+FjJHqOshUFzjTkvMU7bF8qYqXuIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974491; c=relaxed/simple;
	bh=PYNivbd/rIe0+SOm4PQHUy11oOj3cnrLidloOdd8ks4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYeJuShGoM5jjaE9iZep2YzISrvC4CU2PkmjRS53j7pZle/LK6FdV9dTxw/kK4Om4Je2gKbEa1nQzHGWQCZX9QYLY1Tfcvj2trtbPJeJrzBvutlkHfXhyLNz5BpOZOyAncV4ABN2WsCSnQaFS/QYKNKarmpcylLMW8NZaOmF05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsvxB+u1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsvxB+u1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33091F00A3E;
	Sat, 29 Aug 2026 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787974489;
	bh=4jW9Uc3cotp1zalCeJY1Q1PpOwYH471Qa2pGSxwXdfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsvxB+u1biGyCBOAKjfFXEwylLqeNreibNUQg0nrkRO95jd2Q9Ktz36J+NXIyd/F1
	 Uaq+49AjgnEBulEYie5PCQV/tebBdMEoRwSqP1rJFh7IWY1/1cFliF0ZNyifZ2ZM6C
	 DTeyYjYitIJy/mCV3gLtMSSPS2LpFkEna7w49UWGhekl757sXQQ7hDlUGYWx4wYqCT
	 rDvUDhvqUQ1lxIhzzfcr71rKqq17CHFhsu9LhZiy1lmfQ8JGUFz1NzXQH+sAH8T5/Q
	 p8+iNmZ48f4zqEHLQsLLa759WSm6YU5txghqxQGnZauQlRODJf9CAn1Ji6whCGIt0j
	 OwIbJ9pZa7biA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Carlos Llamas <cmllamas@google.com>,
	Lee Jones <lee@kernel.org>,
	Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] HID: uhid: convert to hid_safe_input_report()
Date: Fri, 28 Aug 2026 23:34:35 -0400
Message-ID: <20260828-stable-daily-0004-hid-uhid-safe-input-report@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827220428.2988999-1-cmllamas@google.com>
References: <20260827220428.2988999-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
> the buffer size. This prevents the reported regressions [1], allowing
> hid core to zero-pad the shorter reports safely as expected.

Queued for 6.12, thanks.

Could one of you send adapted backports of the pair for 6.6, 6.1, 5.15 and
5.10?  I would rather have them from people who know the HID core than
do it myself.

-- 
Thanks,
Sasha
