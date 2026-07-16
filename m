Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FE427F87;
	Thu, 16 Jul 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209712; cv=none; b=PXjJBvU3EN1lSGnQDeZs9ENrSetn+LRbHBAPAVWIDy/Ba3LVXFhkHPmXBP7OVirOQRQM2kFsAQWVKDE0Z8n4UDeoYHFyKNztdv78Quf29B+X8OwubFD0PXCBx85dKNyRGU7IwsfVZJpmJuW3wlcn49XqzrI4uuEqZUE6taQjcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209712; c=relaxed/simple;
	bh=389GS9exLcaX9KFuIgE428O3St8o2S93A4O5AEANp6M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KsYyNLKLkcB4zZ1+EJ9n52Gl8gnGMWn3rzgIldEJzpQcWZEbLiQKXlNbpZVxs8mDyCpUluMMYoAccirkG8Ih0P4jNk2J4Mp1Al2cxOmdB7+VIoiULI5hqLPfTgnbM7CYlEJfM1zDMQDRxVp6ypYWxn6pyBm6SbYC4z904N/B/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d940717K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d940717K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FED1F00ACF;
	Thu, 16 Jul 2026 13:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209697;
	bh=389GS9exLcaX9KFuIgE428O3St8o2S93A4O5AEANp6M=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=d940717KghOHFqCD0jGTESEJwea2T5jS9R7KQFUJw6snVDTxle2M1SNnG3bThSThE
	 m3i3+IaYjxVT4nyatOsZMLtloV79p22YRcG/iuqK//Al12RaLEnP4Y+2S93SHDeU2R
	 7MKYHgNfim4JorzpqUEHJLiw++MKGDbnl8W4VaqFtmS1WMFYtUTrwkHTPYEAuIuVFz
	 hoYoBtZlbkHIlWGt5zh8cyVvGLXJkdthvD7XJesAfuI3Wf1SkM7jDcA3s2ituD/Xuj
	 BpEUniJOXvpdK4tZzdO4erRJ74gdSg4JrNkN4OvkOhtuV62cWS+mrfPtIsqXvPXeTq
	 ExbhVfDnRi5RA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 15:48:12 +0200
Message-Id: <DK01JT88NEI6.1TTJR16A61780@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: device: avoid trailing ; in printing macros
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260716-device-trail-semicolon-v1-1-f48e9dcfae15@google.com>
 <CANiq72n3BYGfB9VvLk4-bBQzGy9YhDxFvCrjkjJqBbcJa5YRYw@mail.gmail.com>
In-Reply-To: <CANiq72n3BYGfB9VvLk4-bBQzGy9YhDxFvCrjkjJqBbcJa5YRYw@mail.gmail.com>

On Thu Jul 16, 2026 at 2:17 PM CEST, Miguel Ojeda wrote:
> Ok, I will land this into `rust-fixes` then, and send the PR during
> the weekend after tomorrow's -next.

I can also take it through driver-core-fixes, I have another minor fix to s=
end
anyway.
