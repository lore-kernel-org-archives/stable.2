Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C32471271;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136002; cv=none; b=X+6T0ZYUz9a9eR300xDgB7600xp050BAOwWFhiI081YaFKfqWmn+9a6tl9zbhNvglZCufbxdwbgDOiIzr5QwKC1WhTn9Rb7B2jGpqS3oskQWtJwd3Uvw1FMPOf92mn90z3qHvmZAZ6WQCFajfgD45kxegWeVZPZRtrdwuNUcwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136002; c=relaxed/simple;
	bh=Cw/fHFl2Eir7zBbt81vKWghnrIwiWXTyrhWSuCFHLkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPwd7LE9KYf5C0ptgaPgx1HnQLj7IofsFMehC4C3cUtDZVAwn7af56qJAo7sjZ3gBM11KCwcOO1mIcKgMYzi22bINjmnASGCKJvX0Xq2S3jKWCgHs5fqaTKWKKo0zjC0HHnYqSDgvGtubZ0SLoQkIKraXEAK43VdbmooiH+M60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3049F1F0089A;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DF2F6180B26; Sun, 04 Oct 2026 19:46:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Maurizio Casciano <mauriziocasciano7@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260924225152.985489-1-mauriziocasciano7@gmail.com>
References: <20260924225152.985489-1-mauriziocasciano7@gmail.com>
Subject: Re: [PATCH v2] power: supply: core: Honor supplied-from with
 CONFIG_OF=y
Message-Id: <179113599790.190565.10748898771262119482.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 25 Sep 2026 00:51:52 +0200, Maurizio Casciano wrote:
> The supplied-from device property is the name-based counterpart to
> firmware-node power-supplies references. It was added for non-DT platforms,
> but its parser is compiled only when CONFIG_OF is disabled. CONFIG_OF is
> a global kernel option, so x86 systems commonly enable it even when
> individual power supplies are described by software nodes.
> 
> Consequently, these consumers never populate supplied_from and supplier
> notifications do not reach their external_power_changed() callbacks. On a
> Lenovo Yoga Book YB1-X91L, ftrace showed the Whiskey Cove supplier
> notification running without invoking the BQ25892 callback, leaving the
> input current limit at its boot-time value.
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: Honor supplied-from with CONFIG_OF=y
      commit: 6bd80f22c764fe8c56c62c118387f86a3ca98cff

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

