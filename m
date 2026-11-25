Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624812;
	b=lL6Nu6FQHupMQoG4XB2TiPBCOh18Br8/y2jKFZuleZlYKBqRPlplWQmXrZCGtuFdP50a
	 8/SgVJajZwF6zT8SzGsvqIBlFn4+Y3CfNvFhJKkJbNLBbokLkUiJJoPYZn3Utn68t2dpX
	 0l1VwKJLpmPy0+qw9bkIRZO0csJ4dAdqTGBLfGCXa968K3soLm11SWHGV6XD6BmjEWafw
	 6aLAgiTysi6fAv86RqddgAz3qBJU+Jiv2thn4LMDipMQkvulFdINcwYnjFB3zhDYeTTU0
	 iHBO2mQBr/4XVRDV6TCb+ZL/q43Nj0sQbMQ7rf3sIL4D3MgE/i25EWb6wvHbayoFYpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624812;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XGzfWJQ47/870gyuOMbUB5YEqIZqvi53u0tYNdJdn0c=;
	b=xHRDnzs2vXAEmSWTJbMCru1MqPRODqf/HaAEtJXwruYc4UtJ+PbS6jF1EDeLpja2YOu5
	 +TWhcW7t4fNwXEFM78YHRNY+CKDSj1XUhlCGw3+BmGxoMXYWGZepLEhBGPlBWNU+NsO7A
	 t12cyBgvtZUDmd2lJEGs0qCfaPz+xkQkgbtoY0HbAWQiPeNk1htJsjwLFmSvEFuqufu+4
	 r+i1Vbi/ukXxIAUWWPd+gCDAljUugvipYK3IkjRWhMUw6sLArRv3IWpqHgCCEmMW7f7QW
	 2MdZVfFJNYiBLUvqC6oqb8HXEhAucoxRe42R0rgomAVJ5TYq2lVSC4XWwNAiL0nKYlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/7XacBd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03329606A33A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/7XacBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FE61F000C4;
	Wed, 25 Nov 2026 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624811;
	bh=XGzfWJQ47/870gyuOMbUB5YEqIZqvi53u0tYNdJdn0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/7XacBdXE9R8XSAyGhxuXXJvt7xyPH2Jx0uFTlf7lDTjsywoGwJdEZq98auRxpUz
	 rMjd5kom8Tosv9VQm1yD47OadUObPJuMGqgJYQAeOzIIeTH76G6pIEs2WCW7k+ogvN
	 nFnWQmeP9/sGoGKR4Yt35VyS0cPaUhuNlNWoEARpCEwoTvCjss8OjM8B4d5JvORxd/
	 N2PulJkyeo7M/y2HF/CropVmKJ000p2oHmXWOqBrrDZonNW7s+245BU9J0X+OhGuXq
	 4aRNKHicTOd7Xl+oG7HC26mxry8zAJvLssy6/ClZ6IjWcT+Nam0RoFlqx4nY5M0U65
	 Jf/LZdpj97ZLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] buffer: Document mmb_mark_buffer_dirty()
Date: Wed, 25 Nov 2026 11:40:08 -0500
Message-ID: <20261125163943.826475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112543-dipped-sultry-a7a2@gregkh>
References: <2026112543-dipped-sultry-a7a2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 6c8b7651d06f635fe3d8789eda493eda3b4d13ef ]

Add kernel-doc for mmb_mark_buffer_dirty().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://patch.msgid.link/20260828205429.3678204-5-willy@infradead.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: d4fdde3257a5 ("fs: set I_METADATA_WRITEBACK in mmb_mark_buffer_dirty()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73b1ba..30e7f2cc2386f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -618,6 +618,14 @@ void write_boundary_block(struct block_device *bdev,
 	}
 }
 
+/**
+ * mmb_mark_buffer_dirty - Mark a metadata buffer dirty.
+ * @bh: The buffer to mark dirty.
+ * @mmb: The list of buffers to add the buffer to.
+ *
+ * Mark the buffer dirty and add it to the list if it is not already on
+ * a list.
+ */
 void mmb_mark_buffer_dirty(struct buffer_head *bh,
 			   struct mapping_metadata_bhs *mmb)
 {
-- 
2.53.0

