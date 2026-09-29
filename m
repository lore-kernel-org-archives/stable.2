Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2F3CEBA9;
	Tue, 29 Sep 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674525; cv=none; b=Os1X8Lu79ydp5b7dhLp1hJuWL5hDDkXEsV8OL+zev/CS2xICXB2nehNDu9TJ2PyLFTb16eO8dzdazNz8AmhVjzCbM9n1PSmBsu5OVXwjcnlSPyCWZVb92rX4ODZNUR3PCpVTMk7hWSCwNihf11crZXISwpdu9BP/oU41toW21/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674525; c=relaxed/simple;
	bh=c5KMvk+wlvg05d5682IqGLSe9lTTAGRGL+3Jl6rddIk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FKZwJ8MZ+zlKR20VzWa1cFRCApMdZGr5pUDsj/DZWoa/ZCHG6PX0MShEMy/bHtJBqJKvYut0FgGC7Nt05PlW3B4QH3N0M3IjvYtsaCArYauDKJ5u43vFhB4qDxSCYmXzCrMLDdtcyAssoFtADU//BMmS4Ae4mSfHcUwJ/n0VjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK8/2fmq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK8/2fmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA031F00893;
	Tue, 29 Sep 2026 09:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674524;
	bh=SoIoa7wxArQVZtU1UN6k++LBGSI1aWF8lunhGv/PRt8=;
	h=From:Subject:Date:To:Cc;
	b=WK8/2fmqnsYan661Kcntju0KwLG5w+jx2ctgjoepCVvLiBZimpoOrfAf1d38TG76Q
	 W1qCOnY29fVjDGYtZzstwQm+iN8hgz+G3PLvi4TP0cor1j3nZ+175D4dbK3EISux0k
	 Yi84a7HQZ2PyDHds4zg1hCbx26u3As+UUHHM+wjxZ46GpMHKLN4RlPg8rPg0m4u8kL
	 gO232sw6X60eNq2G6L2RY8cYId17uplTir6SomUGx+E3JRn3aa4QlL2nWYTkqo5wNY
	 hC5ZUcpQO7UHfqVL0IrzMoj9eoqjKaWh1+qm/Xue6IjawPCvJBs7cIj/kpPxEh3tx4
	 Ugtw+i7eoeszg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
Date: Tue, 29 Sep 2026 11:33:58 +0200
Message-Id: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAeGu2oC/yXMwQ6CMAwA0F8hPdsEBtmCv2I8sNJp1TDTAjEh/
 LtDj+/yNjBWYYNztYHyKiZ5KmhOFdB9mG6MMhaDq52ve9ejLjZjfGV6YsqKa8AOlRqMHfo0UBs
 Ctd4TlOCtnOTzyy/Xv22JD6b5GGHfvxw/jWN+AAAA
X-Change-ID: 20260929-rust-block-for-v7-4-rc1-b4-6fac377c366c
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>, 
 stable@vger.kernel.org, 
 "Priya Bala Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan" <ytan089@ucr.edu>, 
 Sophon Z <aiqubits@hotmail.com>, Qingxiao Xu <qingxiao@tamu.edu>, 
 Malte Wechter <maltewechter@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=c5KMvk+wlvg05d5682IqGLSe9lTTAGRGL+3Jl6rddIk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqu4YSSKVgcXdY71DtHu6EcZSOhl7MaSK2jv1rr
 iCwdlF6UyKJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaruGEgAKCRD6UCkIqsW9
 0EuaEACaAzn0fo8Nw740RsgJtBzyg27B2F+I0jK81fGqeaLm9pJJB9cJ3ux7I07IsuDkkYbBeU/
 gRO3reVuWtYGLTULaLKO30zVosYbXt0AvilJr98ly8FuSypzHbK58+fi+1Am2+lePC1qc+nH7Zt
 1bVadwITqFgh3FhfG4lCP68HIgWMmVjrjTN0C1ef94SyquJjGVvu0GxsNpDtkasJyxz7byYLP/Q
 8/JXtI5WdBnTWiantF9zZ+Q8ncAnHnWkYcED4YjjmZvhBSmWr1R9ZStS1ZFHLuPo//1DLskaS9c
 K1BXyDZxVHAT58oy8tcjJiFG/YBqNdwqPQJBkSPSzs6OVKgPmwoSU5C4vKzYttK5HB1jt6KggYY
 IemLReGWrMn6wWpkuA/i1YXDGtMU0LTItUvqEKvBgUdDzRfyZ4cRu6IGUZv85wugNw7PHLtbP1D
 BO9Jrp6hxH6cXqYd0udv8ECb1XVBhOHECzCOaH3eUT2B6B1OHoJFItJSkg9zqetpTwfzldQLaAb
 0EcLYiG3QGupzx5mxfsnpPzgBy/fvEE00SD5qY3yOtCTciapNQlqjhEY0tcjCO/Zo616sSh4Hkd
 GLlx86cy6snqRqcLDASMOG/MCOWu/jWgXY1XvaK5LmxnkKTle4V0e5iywXTYypudH6VFsgPypGF
 yxukt+1nJ6skbcg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Hi Jens,

I have a number of Rust block layer patches I would ask you to pick for
v7.4. I have collected them into a patch series as well as a pull request
so you can use whatever is easier.

The changes cover

 - Style and formatting changes.
 - Documentation fixes.
 - Fixes for missing trait bounds that can cause API unsoundness.
 - A change to set the owner of the file operations vtable in `GenDisk`.
 - Two bug fixes for the rnull driver.

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://github.com/rust-for-linux/linux.git tags/rust-block-for-v7.4-rc1

for you to fetch changes up to b6cfe408d16ecb68a8b10b0d738669aeaecbde6f:

  rust: block: require `Sync` for `Operations::QueueData` (2026-09-29 11:23:27 +0200)

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Alvin Sun (4):
      rust: block: mq: use vertical import style
      rust: block: mq: remove redundant imports and format
      rust: block: rnull: use vertical import style
      rust: block: gen_disk: set fops.owner from driver module pointer

Andreas Hindborg (2):
      rust: block: fix `Send` bound for `GenDisk`
      rust: block: require `Sync` for `Operations::QueueData`

Malte Wechter (1):
      rnull: configfs: add power to configfs features

Qingxiao Xu (1):
      rnull: fix geometry store check-then-act across lock scopes

Sophon Z (1):
      rust: block: Fix GenDiskBuilder block size documentation

 drivers/block/rnull/configfs.rs    | 44 +++++++++++++++--------
 drivers/block/rnull/rnull.rs       | 15 +++++---
 rust/kernel/block/mq/gen_disk.rs   | 72 ++++++++++++++++++++------------------
 rust/kernel/block/mq/operations.rs | 16 ++++++---
 rust/kernel/block/mq/request.rs    | 16 ++++++---
 rust/kernel/block/mq/tag_set.rs    | 28 +++++++--------
 6 files changed, 115 insertions(+), 76 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260929-rust-block-for-v7-4-rc1-b4-6fac377c366c

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


