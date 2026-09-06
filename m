Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002C2253EB
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701648; cv=none; b=NsnmSDYE1IgVXAUVshpcYV0b2vLcrMVzu4W39Bd9mStHs6MvP/XWLd9yQmQEJIcEJRf5ahMvTy8uC/T73dIUAy/wWxrzUHrtwG2//6qVd9fhG25HbSG+Chw67eLfTmKh4U7xYJ5VljsouBqK7pwd9XSDFS+lCqMafqWRO1ylFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701648; c=relaxed/simple;
	bh=ymVRdJFyOxgiS8R9zPkDpIqkkmKojTPpl6KHbWPtt2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuqXmbW4URM1s4s+6BQacfsw+BZAeIVzX/qw2sZs2SjcdHWjKOXpdwSEc/B77rFV2f3bF0mldPbiv0Zu5NKfVHoKD6QBlht57qJ2zFLgBYICfhfpRoi7DGXjI1c9x0LGzCOwP1Xr913UVOC9ChcDSWs9EPsKYLihaZ3FCMsDHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PakxfjmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PakxfjmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2FD1F00AC4;
	Sun,  6 Sep 2026 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701645;
	bh=C5nVHFI3LoSyoqE9QDxvI3eE5vLEeKWcD028KIUxc1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PakxfjmV0YLNxBExBZFF3gzfC+2a/h6EKrqx2EV4O+mp65NtYNRGmQRgN20iK1NHd
	 tFmvCG8TT3zzH/SaomV8x65rTAV38bktKPAaJvO24QuflLAggAFJhlUvIXbofhQCbf
	 nanDzb8HSBLeh3KJiJqkZJI5ScAl0ySHfZNo1jfP0v03poUlz6Hu93pKb0kRbAFypA
	 HBNRKPT1AHkWpkLHhTfmrztoTk4pHndMItLE1eCPw8C+EEAZUBwBuoSRPvZg/+NZ+m
	 r5ytKiSMqJeQ10ImnMUN5ju99mBj3ffs+K7SHZ7Ib2Z8OvLfxFccYlX5GadvQFJbBT
	 7YzUXaP4hT8AA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Stable <stable@vger.kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: Consider cherry-picking 4 patches to 6.12.y and 6.18.y
Date: Sun,  6 Sep 2026 09:33:12 -0400
Message-ID: <2026-09-05-daily-reply-0042-objtool-rust-noreturn-6-18-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANiq72kmYx5GBU7VL3z8h3bAWB=vw-TX+ptskDO0k3Ro-F450w@mail.gmail.com>
References: <CANiq72kmYx5GBU7VL3z8h3bAWB=vw-TX+ptskDO0k3Ro-F450w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Greg, Sasha,
>
> Please consider cherry-picking (in this order):
>
>     c18f35e49049 ("objtool/rust: add one more `noreturn` Rust function")
>     c431b00ca6af ("objtool/rust: add one more `noreturn` Rust function")
>     16861ca3508e ("objtool/rust: add one more `noreturn` Rust function

Queued all 4, in order, for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
