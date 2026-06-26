Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9483A7F66
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496488; cv=none; b=GcT7n3CR7hnl5gpe4T06zdS0l6jl4DE8/tshW/+e14M91Vb8xhsydv8G3ECdz+tOTtMYl860G6ZwlldGtGoLKT9mwNJVRks6LzfoSeSbHTI4QZifoRCBhcIotbWAIqviGC46LT5XgB/iH4EWDFqkUYgTKb8gekBGplAwtWHvKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496488; c=relaxed/simple;
	bh=xP1hE/kiDK1RcZ8UcHonlrjWBwN5/XTba/2JU15/5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alfOOQlwWYqchXodH7cFJta3tvy5SIe7P8OSGq6Xap05eVBOQrFpXFnid+IT0dwOljzwKYmrHABmIZycwlz4BWQWW3iKuDC9uM5JlmZKIs8EGIs9zYUVL46UacgVyApm/CFjL0c1kfC7KKw3l08G4Q0Cyy9NHjEdOHWbMq8MREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1ZJdKpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1ZJdKpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D1F1F00A3E;
	Fri, 26 Jun 2026 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496487;
	bh=mJsz3LYA9sbvctI+AfrGpW/NYWRG+T95iea37SGtAK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1ZJdKpaOS8+2LCh/trrE/h1lMRNZymgShmlG3xnkhfQxwT2BA+pTO/TRCie/hPWb
	 hjRwYI5gxEiwIj/8Qf0JiJGDyUZ/rnH7IbpqrG8fQD80g928vjkTQepeDLiOXvlp+R
	 krGvHANCLx8XcaP8S7DtFbA85Y0XFd/rnJoMR2Y0Fhd5inVemem1A7jRzA0e4rgLbW
	 3zjDhIarpUOcahyhVrTO/K/YRqsbzB4OxP4kPnv2sA8dlKu4deekFk1zcLBNryLW4e
	 C2KYIsRhzWsZc7wDds1+/ZsysLEgcwZ4gOFAaKLVrEHDhH0u4RJXR57N5FC8OkYUyC
	 DKcXJXB2FWejA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	brauner@kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Fri, 26 Jun 2026 13:54:18 -0400
Message-ID: <stable-reply-item005-eventpoll-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll /
> struct file UAF (CVE-2026-46242)

Whole series queued for 6.6, thanks.

-- 
Thanks,
Sasha
