Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870441;
	b=NQM4022YBme/7SOKE9VDYjVHRrp0vWl8mHbe6TINizer5YZVFRNizvU7+yM/n0YE6elD
	 mXIFzIC2wZqOOwiNI+MUP1sV3dtprumgZrlcnJTmsTFASJuB7+PgB1DBbasrF99Xv9lZg
	 hSJzqSYu+EgmCLTga33yIhah1BYWhu0WRnNo2CxEvCvf95eALyNNxM+5dPzZG6m0Dfxth
	 s/H8SV04aNs1tDclBX8mzXxEj96ZiqE+x1NTFMnWNz8s+sm3veyZ4DOhVN+XD27Fl/L1P
	 1WI74ufVsG0sqtMNjcvWFjcbAtcxTjzx9KqerRTG8U7frXWr5SfmYTCuumALgj014BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870441;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K/YqJ70WtM68OplnnT60Ts+qwHgnTXxv+WitwpV0fGs=;
	b=y9zZVfX7b0F+0j6p4Z01LXjFg6dQrVNjNrfqHb+HVK3oqVTs60cDTgWb9woHRqyJ75so
	 5Nq9WMlln5U9bN7yAdTrIs/ZmDx6cB5qAeC5UATsg6aJbPE5lrKd+YaTqwA6pKrudRvxD
	 jBd+NEjD9yKF4723hx51HJ9JYx0X+jM4h87Tc61HuYRVHhFszQio1KVuFY3SuK1ic2Z2F
	 dXZB4o1wfyy5xhjOwwAI1n+8B5TYqrMG1HzRT/xWO3ZZDWvUquj1sFwKddc4N6k70ThE/
	 1xvWQdC0sEu29AVrxw71lQxplzt7iKK3ISyAoTacfGWc4fKzTDIuuzexdHY1l9pV9Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miWmgsAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0B08A606A326;
	Thu,  5 Nov 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miWmgsAl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C86191F000C1;
	Thu,  5 Nov 2026 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870440;
	bh=K/YqJ70WtM68OplnnT60Ts+qwHgnTXxv+WitwpV0fGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=miWmgsAlQsW2g/6GqXZXs7HDKqrz0hX8ECFyo9/dER3KQRv4Nrlt8IZaMtd+QQiq+
	 ikyawevf62LrNTsa6TsnLg7b8lFHcfgcxyZXtgk360/mcFtz76KKgX7xN1S+cTdOA+
	 wQUCazPFfBiNtJtbfBharCHOHkRw2jYPaK8gfYp+iyXnjvGBH3QQJCCCp4tehG8MAP
	 MVjJ4L05apJOAyb4nID2pFbAoTURDYvXFp5HXgQwXehCQCfNz5FkCG7jbFLyo4ZTyX
	 SXRy5RTsrZJ7mO9SFmu6lHk70Y4BgZytoLvpZpvpXctQuFP4ElBjsLgSricoX0lzX4
	 BODq1+QNTBM3w==
Date: Thu, 5 Nov 2026 10:20:37 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: fix use-after-free in ibs debugfs
 files
Message-ID: <yzzwzqczviza6m2c6xohghlqlo53fwottlxqclzy3udes2zosq@qnquko4f3buw>
References: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>

On Thu, Nov 05, 2026 at 01:56:45PM +0800, YuanZhe Liu wrote:
> qca_debugfs_init() creates an "ibs" directory under hdev->debugfs and
> stores pointers to fields of struct qca_data in the debugfs files.
> qca_close() frees qca_data without removing that directory, while
> hdev->debugfs is only removed when the HCI device is released. The HCI
> device can outlive the driver data, for example when an HCI socket still
> references it, so reading or writing one of the ibs files then
> dereferences freed memory.
> 
> Store the directory dentry in struct qca_data and remove the directory
> with debugfs_remove_recursive() before qca_data is freed.
> debugfs_remove() waits for callers that are already inside the file
> operations, and any later access fails with -EIO instead of reaching the
> debugfs helpers. This covers the two writable files as well.
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102113654.8724-1-25031212351%40stu.xidian.edu.cn
> Fixes: 0ff252c1976d ("Bluetooth: hciuart: Add support QCA chipset for UART")
> Cc: stable@vger.kernel.org
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> 
