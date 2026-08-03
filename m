Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF535AC1B;
	Mon,  3 Aug 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798117; cv=none; b=HiIvvU3YP7XbruBDoEUZ9FSCgOzLxuytG2uu4Kn60DR1aDYBE6g3eJlyIJ1IHNROjX8+QednnqyoqMa4HhqAn5OBdhXoBI/OQvaOMzJKhEYRzNNUn2SASCjDCqHjtqwcLBmzPJKqihNrCxiQkm9Mh3jqH9pNEvKjZ8o1i/I+ZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798117; c=relaxed/simple;
	bh=PuTJMmP9dKz+WBRPGKDynihKXhcewSang6kZr3Z2kWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r7fQRU/ivUdbxxiBSJ1HZ9vdkfNpa1u2LzKDQ9j9ewwHrpcqqGvhwW5yGa2u8CmUZGq1tssvgLwzg7SeBFTXOAe/GGpd664UpTng0u7g3phM7WFYxmddX50/f12LmwhqdHhkl+8v8rrlLt7XMJ0v3lsfZWiGYV1Gl0wC/WclGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF8A1F00A3E;
	Mon,  3 Aug 2026 23:01:56 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B05E618060E; Tue, 04 Aug 2026 01:01:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: sre@kernel.org, linusw@kernel.org, arun.murthy@stericsson.com, 
 anton.vorontsov@linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260802020316.417757-1-fanwu01@zju.edu.cn>
References: <20260802020316.417757-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] power: supply: ab8500_fg: fix use-after-free on remove
Message-Id: <178579811468.234019.4487541526073009513.b4-ty@b4>
Date: Tue, 04 Aug 2026 01:01:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 02 Aug 2026 02:03:16 +0000, Fan Wu wrote:
> ab8500_fg_remove() destroys the driver workqueue while the threaded
> interrupt handlers are still armed; they are devm-managed and freed
> only after ->remove() returns, so a handler that fires in that
> window queues work on the freed workqueue.
> 
> Tear the workqueue down through devm instead, registering its cleanup
> after the power supply and before the interrupt requests.  devm then
> frees the interrupts first, so the handlers can no longer queue work,
> before disabling the delayed and plain work items and destroying the
> workqueue.  Disabling the items, rather than cancelling them, keeps
> them disabled so no producer (including the power-supply
> external_power_changed callback) can requeue them.
> 
> [...]

Applied, thanks!

[1/1] power: supply: ab8500_fg: fix use-after-free on remove
      commit: 75b1e88d34254f4fb7753345e21bfee47abddd7f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

