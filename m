Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166031355C;
	Wed, 12 Aug 2026 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512313; cv=none; b=TJCI6M/oc7ZYUsjkU0I/bqjBU0XHzII02JnY8Lw9VbYFYPqaUk4wrVgYT81LlkBsZa8OFOgUIEBXpxGags8ABrhhIru53p16NRULvUt/S5XZCDnYZMtTE0YAHZbhHgV18Go8U7mACDT7eWfdl8Y96/MzgB1BCjPEO7h0HNtuwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512313; c=relaxed/simple;
	bh=KGaBHN4E32+eD1xus4KQt6sFROwBOr9CL7SGEfl1Jik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXpMJCHOPFaSxNsnwlfeT6n732TjqBwsIUuifQt9mZi/FbMaUl8YnUVG/6mwEo4sni6AViO9zp7HQQO/9KSLedRTbnOjBdyApZcPGUw89y/nFrW2spLSUVOuIupvJLS3Udn9g08r2bvML41u0M+veLw/0FIEogfa2gBfi1KWgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=PwMqUyXj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUSNQKe/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PwMqUyXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUSNQKe/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CFEE7A00C8;
	Wed, 12 Aug 2026 01:25:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 01:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786512309; x=1786598709; bh=28nPvFuVpI
	YU5pV5aG0THofF4Ustxv56B0tybpBYheE=; b=PwMqUyXj1JeJMJwmopqiz0GFse
	DNN12b2fXK5Ehf87O9Z6ufmFI2jFAzbCYtPCyjA+kvP/CiqD73ENS+48oxGDAoqo
	RT0vnNgsQ/lv4ToxPy2mVNpEEwlrJS2lEEKnu6NxF3Ut0FjrariBpCQQXF3hOVCL
	vyj8LJOMkjEE+Ujl6Z5OAH6Ue4cg6j1stkIz5F/6lkhVG7i0zxEWEti8niUrU+XI
	oZst+sXF0tR8O/TwElRoJ+NmI2jx9+7jFeYFvnZauwo1nZ6/c+UzvOUzBs1dEZOj
	JNylrwnThQODpYyZwpk/nVhjtr2qbMte6FT1ZxZYv6zO5ruriMSCQj1Sk7hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786512309; x=1786598709; bh=28nPvFuVpIYU5pV5aG0THofF4Ustxv56B0t
	ybpBYheE=; b=mUSNQKe/34Yv6SpKEVAWfyia1Z9ABOKV8XDhvU4lo7B37Gve8lP
	HjPbX6OOEEzko4PwlO2k/zIAu4bGpCRAULzU1ZF1ew7TdgY5ituQA5sUR/DcPPvI
	VHX9rY6T6AnGTlZhZKfANQpBpVQBKqcD5Q/PBaCnVnsx6OeIw3mZeH5uNBnLCAm0
	pIFaYAkejMN2x3JxPRioLs0dVogqgpMMi6jNl1D/r6K1U5FTENqlgJSLMqqKzDpN
	ZwHwOIwbRtw1CqhZq6ZHRUkwKTYUvgO/kGVvCXwcIlMAYOirEd/J8VNOhGph/xT8
	PbIcSxabuf+YoP9LTU/MIOh7QhCYuDk8T8A==
X-ME-Sender: <xms:tAN8av8FlY4_7fawhXNS2sGeiQsxEww-hxWNg0cR4veLBOAk-EtZiQ>
    <xme:tAN8asolI34Zl7G_Fho9eIru22vHHuqac3aRxc7XRiqbEzEszUflZM8Ft6pqnRmrv
    p39QgaZQqD5Gc0-t8YeDDgYbGsKdwB-wz9ZrGGXPsp8e0y3wg>
X-ME-Received: <xmr:tAN8atWYzyklDZc45PnxqUj83hHcBK6gLOThyMAUduZutBGn_6F_UAg>
X-ME-Proxy-Cause: dmFkZTFr0akD6lmTxJrZbE8su1kplFOautjQj2TvjR3JGl06nJdMnzMO0H6t2V3D0g2T5B
    GQ/p81FPfKke26FaecXeU2jvao1vycAjE9zrvjPn8FoUxIqEi/NCo6RkbjtTxaDYEFN5Rz
    Atw5PxK3jDFzJuaMuLh14j51WUQheOVFaE2qQwLB0GvRb3g6tfMH64qw+XLsVFs3fNl4pz
    3GlnqEV+ZR5ZT2sOUIsOQzZQRRSgek7eQU+AogS+Xdk9qMpx6D68dfuJ6JtjKtmOWZiJe7
    Lm/l5b56aJtwyiUix90mGmFpfF2KuRb+OfvVVcXaHnZhBEH63a4oBqCS9vltVOJV50ogVN
    jLAvdpczwVPZUL4f/AjhWYuI2saft1HZrrEV1uj56w92cZxR/1vQncrwoCajWwfe/w9NaK
    5OXJT+2wDpYUYM24G4D8+lvpTAQ9cPKWzmSUg+X3Vo5XaBkSxQgRP+cirFQ28caXMWREbB
    QU/EhfppdFRMDusLiXTuZe4upEWt/81SZ/bdp4Vhry9gaKzrbbFpMuW0oKQEFuA57oWKWP
    p9a3S4QDaiLSPA8LQGfCD4CqasgETzc8tlUlu3cD0nUX+A5RD+PBoBK8WC+JSFeaxtIyRN
    bmWYIpTXUhFjL60yvoeLHziki/i1RNO3ydIuwkFPNSkEhS2fhsLDsZDOe8eA
X-ME-Proxy: <xmx:tAN8ap46kZiIX1YvsuWArVFKtJfABSZx0mnUiq3SxaD1JxhAHDSiTw>
    <xmx:tAN8arCLHTi8aWfiK00g3n3ZtgAjREitCQl8cyjPT6vyVLAotGYW5w>
    <xmx:tAN8atdYmR8q80iVObRudg1ZVuT9KmZPmD5cBfnbK4sMcECRsf-fxg>
    <xmx:tAN8asuZMVWhotMoZ6sWhD46aZaN3Ow4uLH9GPlfOXdB5YD1HbuMRw>
    <xmx:tQN8alBlP1LiNgGqd68mGB0SJi-Hsfs3gpsYk4E5KdYtPjaS79azM5-l>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 01:25:07 -0400 (EDT)
Date: Wed, 12 Aug 2026 14:23:34 +0900
From: Greg KH <greg@kroah.com>
To: Jason Colapietro <jasoncola1@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	skhan@linuxfoundation.org, Hongren Zheng <i@zenithal.me>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usbip: make remote list honor parsable output
Message-ID: <2026081214-litigator-nutty-83fb@gregkh>
References: <CA+Z0x2JOUKR6cH41JyFHBmG5L_XoVEa02vrc91-L42RX5oa5OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Z0x2JOUKR6cH41JyFHBmG5L_XoVEa02vrc91-L42RX5oa5OA@mail.gmail.com>

On Tue, Aug 11, 2026 at 11:26:44PM -0400, Jason Colapietro wrote:
> The -p option only affects local devices and gadgets. Remote lists still
> print their human-readable headings and details, so scripts cannot parse
> them using the documented option.
> 
> Pass the parsable flag through the remote listing path. Emit the same busid
> and usbid record used for local devices while continuing to consume every
> interface record from the server.
> 
> Fixes: e9837bbb3e69 ("staging: usbip: userspace tools v1.0.0")
> Closes:
> https://www.google.com/url?q=https://bugzilla.kernel.org/show_bug.cgi?id%3D219502&source=gmail&ust=1786591574713000&sa=E
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Jason Colapietro <jasoncola1@gmail.com>
> ---
> Changes in v3:
> - No functional change; resent as 1/2 of a series.
> - 2/2 makes -p work regardless of where it appears on the command line.
> 
> tools/usb/usbip/src/usbip_list.c | 33 ++++++++++++++++++++------------
> 1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/usb/usbip/src/usbip_list.c
> b/tools/usb/usbip/src/usbip_list.c
> index 3d810bcca02..b9d60b87e47 100644
> --- a/tools/usb/usbip/src/usbip_list.c
> +++ b/tools/usb/usbip/src/usbip_list.c
> @@ -41,7 +41,7 @@ void usbip_list_usage(void)
> printf("usage: %s", usbip_list_usage_string);
> }
> 
> -static int get_exported_devices(char *host, int sockfd)
> +static int get_exported_devices(char *host, int sockfd, bool parsable)
> {
> char product_name[100];
> char class_name[100];
> @@ -80,9 +80,11 @@ static int get_exported_devices(char *host, int sockfd)
> return 0;
> }
> 
> - printf("Exportable USB devices\n");
> - printf("======================\n");
> - printf(" - %s\n", host);
> + if (!parsable) {
> + printf("Exportable USB devices\n");
> + printf("======================\n");
> + printf(" - %s\n", host);
> + }

Something went wrong with your email client and it sent html email with
a corrupted patch :(
