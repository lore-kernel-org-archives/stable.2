Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B348C408;
	Tue, 21 Jul 2026 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635725; cv=none; b=eO8JFtJDvmi4pCihepSIn7Jr+85n3MpBbKwyqk/BcbeXJARa/EaCsk0eDMS64drap8WnH2yhmMKwmsE/j6aMCusuLd43QMOdv4cazxBLIwrobl6D2eAHTv/CaGMjnbwqffNqgyXsqYqaQlY2spFvA4hTdY3fwctnmV5my+aGtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635725; c=relaxed/simple;
	bh=6XVl8CINWvYEzIGmsY8sKNYifQod1+ZHPNDENyXpF5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQk7f6C0GDZxiOiNp14rId5N/cdQt0TmWBwtXs3bpdU4NORfPNAEqAFAW8Csbmba8ESXnSdN67tcSQTpFRocT3joVvx17Z2HQ7THcqXT1CABq6iu7v3Fc/hoT6anzGxBZ+hsZ5mJv8Z5rEXUp7jz4Pmw6u06aFsUslnejfpHKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txbbr7jT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txbbr7jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF581F000E9;
	Tue, 21 Jul 2026 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635724;
	bh=SL4r1Q6qN4OxGEySHC6+JHdyhSATXZG1LqkgWQGzEHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Txbbr7jTcVuNUV32z9MVaZL5p/w2n78o7n6I5W9hd7Qwrzyge3RZXvj321VZf1cA5
	 /7E9jjcUYfhKfEAT/SwtC/BWz1ivE1qaa+/y4XVQENLdZ0d8dntyjjqMxHZQkT+eMe
	 cG3QfxhZSwYgOsuMNzlCi+MS65+KxTEeBf6MQKxsDYm6a3qbDu69eoDnEgxrtXkI4P
	 XjPWBC3kbJzQGjWsg56VTU3JcNgUQvvDyz5qSeJtFob1z1JwUMvUZevFOdSx6/z0iM
	 WB1XvOOxYQDPwxnHGnzPVJZI8IQc8YX2hi2PLbL8clsR8agvOdE0rxZgqD+L09KzxR
	 oaF1qgNSuTgBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	adzicmirko97@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: Patch "rust: pin-init: internal: suppress `non_snake_case` lint in `[pin_]init!`" has been added to the 7.1-stable tree
Date: Tue, 21 Jul 2026 08:08:35 -0400
Message-ID: <20260721120236.100001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DK3HV8BJG6G6.1URBMSOVVLT7@garyguo.net>
References: <20260720105951.247306-1-sashal@kernel.org> <DK3HV8BJG6G6.1URBMSOVVLT7@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 20, 2026 at 04:13:24PM +0100, Gary Guo wrote:
>Looks like quite a lot of patches have been picked up as dependency in order to
>pick this to 7.1.
>
>The warning that this fix addresses are already worked around on the user side,
>so it probably isn't worth backporting.

Dropped from the 7.1 queue along with the following dependencies:

  - rust: pin-init: internal: remove redundant `pin` filtering
  - rust: pin-init: internal: turn PhantomPinned error into a warning
  - rust: pin-init: internal: remove collect_tuple polyfill
  - rust: pin-init: internal: pin_data: use closure for handling
  - rust: pin-init: internal: pin_data: add struct to record
  - rust: pin-init: internal: init: handle code blocks early
  - rust: pin-init: internal: use marker on drop guard type for pinned fields
  - rust: pin-init: internal: project slots instead of references

Thanks for the report!

-- 
Thanks,
Sasha
