Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3652843B;
	Wed, 23 Sep 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169391; cv=none; b=UUTJmEw9jKqxhjc4iXWL24HBRDUAKZ0/kd+J1ehrWESSFWtJgC3BP5LvXf3rdR8e/IzC56rcz7I57/nllNxykZqnzARKGz3+xf3WcGRp7yvcUVQzHEuwas37wtb7ttDESpCvmK74mG0e56LY3KdXAC44PCEf3HAzwpcfTTDpf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169391; c=relaxed/simple;
	bh=laxu0XICh0FruO323Ek2WNmSS/DIqBoqqxhMOOAFBXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h1n9Pm7mTPyc6FgUNfLVtdht7njC8MXVXPebo55j/m9EM0VHL+4l+qmcfHNWMmUnvjTgW3WUHIVQHKEwWjKUfcP/JUal10JJT/aATfYxDkOIKlzriOOBOncV8enf+zSu8bmj4tsfKBL4FH26Wf+Dt0TW1y3E9ChCrK0IW8umONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmI1yRxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmI1yRxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B511F000FF;
	Wed, 23 Sep 2026 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169390;
	bh=6jN5u0qLZBqMIXt3hA1bh2BMnMKSc2M/6jWHcuYXZGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HmI1yRxZKmi85+6oMHzF9A4ofU0qNLPphC0VCIIP1rzB5RqlW/21lGYu+mKKgbHvD
	 TLOH+mrz/xzldFgQb1qGZfogT6xVlkryMSIVhQOAmcPq7UhxYAmW1kJxMfKompgfam
	 jGXtVNwagGBphAYLJFf0vWBJNuebmlANrSZI3fWeUEzcvwnb/kTsM/yDTqoWDbx+NI
	 2wxtjIBNvcD+4AxPiEqKmXpjSS7PCTjZurqWYKJydh+Ze3joq8FZVal5BYzrXNYoK+
	 y3rrds1xJJkYVFAhWuj53LZuICHu7u74SulWWLtQB5Qf/zpStj9MNizsysOvOLpaC6
	 KKUrN+Lkng7qQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko AI review <sashiko-bot@kernel.org>
In-Reply-To: <20260923115847.3396019-1-qwe.aldo@gmail.com>
References: <20260923115847.3396019-1-qwe.aldo@gmail.com>
Subject: Re: [PATCH RESEND] HID: multitouch: stop the release timer from
 being rearmed on remove
Message-Id: <179016938872.57615.1191765081689806784.b4-ty@b4>
Date: Wed, 23 Sep 2026 15:16:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 23 Sep 2026 08:58:47 -0300, Aldo Ariel Panzardo wrote:
> mt_remove() quiesces the sticky-finger timer before stopping the
> hardware:
> 
>     timer_delete_sync(&td->release_timer);
> 
>     sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
>     hid_hw_stop(hdev);
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/1] HID: multitouch: stop the release timer from being rearmed on remove
      https://git.kernel.org/hid/hid/c/5acb2dace582

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

