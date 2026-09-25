Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77514448BA7;
	Fri, 25 Sep 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325126; cv=none; b=pw/3J6lvMQk0HOnUBu4JFBxfaZiXq5R9BABVCBx1fMEVAqxHCoWL7IU0gUxMUWTlP27Fna62qlC4+3WjLjV1UMT9JZmcyK79O7U44DpqX3UUlx25to+wNoiuMLcvzld9IOCRqHqNXbVRZScwUTCeTB59YGXfUBl6sfrNku9sdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325126; c=relaxed/simple;
	bh=t47BzwwXIFhA+OXA5Pgu2sP3rEwCeyovyc5A2lLgu1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ITTP3cAg20IDf9vQyS583hrzViTUJW5/OnZI8zdsobAaTsTc6muiGGeEmuaUXTAzDjVP1v+VXixq03SclGfp2JZ7Y4ujKkK4NnL3NeviYhU7pv19BX9sPj6lZclPy+Yaes1R3At64rR6nt3pTcN43pIdr2s9fz6FbpaIHXW6QFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax2rY14H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax2rY14H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C1F1F000FF;
	Fri, 25 Sep 2026 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325121;
	bh=f21bfSgajoZ96zkKMMzYLpGU2lQgnejSnZbLSzP7oqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ax2rY14HrX3kBp9ZOKN/2lxZDzfwKLCfKd7UmShTsrwoMDi/2+GMdW5k6Uk7j+y1x
	 360aNj2JRWu3NaDYu1YHhO80vitYvlWd5PM+ps4QlQrhpWxVvwpZJ+kSyqJRYbUEnc
	 M4D+o+cGrsZa6wqa+w6gN2iB6OPdx/32U70dt9erdKyD/drU+G4XV/v2EOFWyi4To8
	 55a11O+WMGeOxH0tAW6SplHBK9dckq1yqfq2O1gRgPaNAv8DH0YirsdnQU30M6dZHu
	 sZnHPA4XaUoAAJ8bpxKh3djbVJnaDxIkW+GkNs5druTz9GKLt1dXRQyAdnztBM/6JH
	 C8PsDnYlZWDBg==
From: Srinivas Kandagatla <srini@kernel.org>
To: gregkh@linuxfoundation.org, Zongmin Zhou <min_halo@163.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Zongmin Zhou <zhouzongmin@kylinos.cn>, stable@vger.kernel.org
In-Reply-To: <20260924062856.42977-1-min_halo@163.com>
References: <e76a151b-4dde-4bdd-91ee-e025e9bcc994@163.com>
 <20260924062856.42977-1-min_halo@163.com>
Subject: Re: [PATCH v2] slimbus: messaging: fix leaked PM vote on tid
 allocation failure
Message-Id: <179032512009.104177.10348463176756654367.b4-ty@kernel.org>
Date: Fri, 25 Sep 2026 09:32:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 24 Sep 2026 14:28:56 +0800, Zongmin Zhou wrote:
> In slim_do_transfer(), when a transaction needs a tid and
> slim_alloc_txn_tid() fails, the function returns directly instead of
> jumping to slim_xfer_err. The runtime PM vote taken earlier with
> pm_runtime_get_sync() is then never released, leaving the controller
> permanently powered up.
> 
> As txn->tid is still 0 at that point, jumping to slim_xfer_err drops
> the vote exactly like it is done for other failed transactions.
> 
> [...]

Applied, thanks!

[1/1] slimbus: messaging: fix leaked PM vote on tid allocation failure
      commit: d4af0dab1a6ffc5bc3688a34358be68ee93561c1

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

